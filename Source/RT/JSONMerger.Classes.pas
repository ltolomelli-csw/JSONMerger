unit JSONMerger.Classes;

interface

uses
  System.Classes, System.SysUtils, System.JSON;

type
  TJSONMerger = class(TComponent)
  private
    const
      C_JSON_NOTESSECTIONS = 'notesections';
      C_JSON_ATTACHMENTS = 'attachments';

    function AttributeExists(const AJObj: TJSONObject; const AAttributeName: string): Boolean; overload;
    function AttributeExists(const AJObj: TJSONObject; const AAttributeName: string;
      out AJValue: TJSONValue): Boolean; overload;
  public
    /// <summary>
    ///   Funzione che effettua il merge tra due oggetti JSON. L'attributo AWrapperAttr lascia al chiamante
    ///   la decisione di racchiudere o meno l'oggetto risultante dal merge in un attributo il cui nome è quello indicato
    /// </summary>
    /// <remarks>
    ///   <list type="bullet">
    ///     <item>
    ///       Ritorna sempre una nuova istanza di un oggetto TJSONObject
    ///       tranne nel caso in cui i due oggetti per cui fare il merge
    ///       sono vuoti e non è stato indicato AWrapperAttr
    ///     </item>
    ///     <item>
    ///       Se in entrambi gli oggetti è presente lo stesso attributo di
    ///       tipo diverso da TJSONArray, l'attributo di AObj1 ha
    ///       precedenza
    ///     </item>
    ///     <item>
    ///       Se in entrambi gli oggetti è presente lo stesso attributo di
    ///       tipo uguale a TJSONArray, gli elementi dell'array di AObj2
    ///       vengono aggiunti in append all'array di AObj1
    ///     </item>
    ///   </list>
    /// </remarks>
    function Merge(const AJObj1, AJObj2: TJSONObject; const AWrapperAttr: string = ''): TJSONObject;
  end;

implementation

{ TJSONMerger }

function TJSONMerger.AttributeExists(const AJObj: TJSONObject; const AAttributeName: string;
  out AJValue: TJSONValue): Boolean;
begin
  // sostituito GetValue con FindValue perchè con il secondo è possibile indicare un Path invece di un singolo nome
  // questo si rende necessario per quei file JSON tipo LottiBFAcq che, per ogni singola entità,
  // contengono un TJSONArray "rows" che compongono una singola entità
//  Result := AJObj.GetValue(AAttributeName.ToLower) <> nil;
  AJValue := AJObj.FindValue(AAttributeName.ToLower);
  Result := AJValue <> nil;
end;

function TJSONMerger.AttributeExists(const AJObj: TJSONObject; const AAttributeName: string): Boolean;
var
  LJValue: TJSONValue;
begin
  Result := AttributeExists(AJObj, AAttributeName, LJValue);
end;

function TJSONMerger.Merge(const AJObj1, AJObj2: TJSONObject;
  const AWrapperAttr: string): TJSONObject;
var
  I: Integer;
  LJTmp: TJSONObject;
  LJPair: TJSONPair;
  LAttrNameToMerge: string;
  LJValueResult: TJSONValue;
  LJArrToMerge, LJArrResult: TJSONArray;
  J: Integer;
begin
  if not(Assigned(AJObj1)) and (not(Assigned(AJObj2))) then
  begin
    if AWrapperAttr <> '' then
      // ritorno un oggetto con l'attributo Wrapper il cui valore è null
      Exit(TJSONObject.Create.AddPair( AWrapperAttr, TJSONNull.Create ))
    else
      // non ritorno nulla
      Exit(nil);
  end;

  LJTmp := nil;
  try
    if not(Assigned(AJObj1)) then
    begin
      // esco se non è assegnato il primo oggetto
      LJTmp := AJObj2.Clone as TJSONObject;
      Exit;
    end;

    LJTmp := AJObj1.Clone as TJSONObject;
    // esco se non è assegnato il secondo oggetto
    if not(Assigned(AJObj2)) then
      Exit;

    // partendo dall'oggetto AJObj2, vado a verificare se posso aggiungere i suoi attributi al risultando
    for I := 0 to AJObj2.Count -1 do
    begin
      // gli unici casi particolari sono per gli attributi notesections e attachments (che sono array) per cui viene fatto
      // un append dei valori del secondo oggetto, per tutti gli altri si mantiene l'eventuale attributo contenuto
      // nell'oggetto LJTmp
      LJPair := AJObj2.Pairs[I];
      LAttrNameToMerge := LJPair.JsonString.Value;

      // se l'attributo non c'è nel risultato, lo aggiungo e passo al successivo
      if not(AttributeExists( LJTmp, LAttrNameToMerge, LJValueResult )) then
      begin
        LJTmp.AddPair( LAttrNameToMerge, LJPair.JsonValue );
        Continue;
      end;

      // l'attributo da aggiungere non è di tipo TJSONArray e non lo è nemmeno l'attributo nel LJTmp:
      // passo oltre perchè mantengo l'attributo esistente
      if not(LJPair.JsonValue is TJSONArray) or not(LJValueResult is TJSONArray) then
        Continue;

      // se il valore dell'attributo è un TJSONArray in entrambi i JSON, allora aggiungo in append i valori
      // recuperati da AJObj2
      LJArrToMerge := TJSONArray(LJPair.JsonValue);
      LJArrResult  := TJSONArray(LJValueResult);
      for J := 0 to LJArrToMerge.Count -1 do
        LJArrResult.AddElement( LJArrToMerge[J] );
    end;
  finally
    // racchiudo tutto nell'attributo di wrapping
    if AWrapperAttr <> '' then
      Result := TJSONObject.Create.AddPair( AWrapperAttr, LJTmp )
    else
      Result := LJTmp;
  end;
end;

end.
