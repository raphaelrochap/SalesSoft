unit SalesSoftUtils;

interface

uses
  VCL.Controls;

type
  TSalesSoftUtils = class
  private
  public
      const CRLF = #13#10;
      class procedure SetarFoco(pComponente: TWinControl);
      class function IIF(condicao: Boolean; value1, value2: Variant): Variant;
  end;

implementation

class procedure TSalesSoftUtils.SetarFoco(pComponente: TWinControl);
begin
  if (pComponente.CanFocus()) then
    pComponente.SetFocus();
end;

class function TSalesSoftUtils.IIF(condicao: Boolean; value1, value2 : Variant) : Variant;
begin
  if (condicao) then
    result := value1
  else
    result := value2
end;


end.
