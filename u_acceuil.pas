unit u_acceuil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type



  { Tf_acceuil }




  Tf_acceuil = class(TForm)
    lbl_acceuil: TLabel;
    pnl_acceuil: TPanel;
    procedure Init;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_acceuil: Tf_acceuil;

implementation

{$R *.lfm}

uses u_feuille_style;

procedure Tf_acceuil.FormCreate(Sender: TObject);
begin

end;



procedure Tf_acceuil.FormShow(Sender: TObject);
 begin
   style.panel_travail (pnl_acceuil);
 end;


procedure Tf_acceuil.Init;
 begin
   style.panel_travail (pnl_acceuil);
 end;


end.

