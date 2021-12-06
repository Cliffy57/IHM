unit u_list_adherent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, Spin, u_liste;

type

  { Tf_list_adherent }

  Tf_list_adherent = class(TF_liste)
    procedure btn_line_addClick(Sender: TObject);
    procedure btn_line_deleteClick(Sender: TObject);
    procedure btn_line_detailClick(Sender: TObject);
    procedure btn_line_editClick(Sender: TObject);
    procedure Init;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_list_adherent: Tf_list_adherent;

implementation

{$R *.lfm}

    uses u_feuille_style , u_detail_adherent , u_modele ;

procedure Tf_list_adherent.btn_line_addClick(Sender: TObject);
begin
   f_detail_adherent.add;

end;

procedure Tf_list_adherent.btn_line_deleteClick(Sender: TObject);
begin
  f_detail_adherent.delete (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_adherent.btn_line_detailClick(Sender: TObject);
begin
  f_detail_adherent.detail (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_adherent.btn_line_editClick(Sender: TObject);
begin
   f_detail_adherent.edit (sg_liste.cells[0,sg_liste.row]);

end;

    procedure Tf_list_adherent.Init;
    begin
     style.panel_travail(pnl_titre);
     style.panel_travail(pnl_btn);
     style.panel_travail(pnl_affi);
     style.grille (sg_liste);
     f_list_adherent.affi_data(modele.adherent_liste_tous); //affiche les adherents direct
    end;

end.

