unit u_adherent_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, StdCtrls, u_liste;

type

  { Tf_adherent_list }

  Tf_adherent_list = class(TF_liste)
    lbl_adhesion_total: TLabel;
    lbl_titre: TLabel;
    procedure btn_line_addClick(Sender: TObject);
    procedure btn_line_deleteClick(Sender: TObject);
    procedure Init (affi : boolean);
    procedure affi_total;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_adherent_list: Tf_adherent_list;

implementation

{$R *.lfm}

uses u_feuille_style, u_adherent_ajout;

procedure  Tf_adherent_list.Init (affi : boolean);
begin
   style.panel_travail(pnl_titre);
   style.panel_travail(pnl_btn);
   style.panel_travail(pnl_affi);
   style.label_titre  (lbl_adhesion_total);
   style.grille (sg_liste);
   sg_liste.Columns[2].Alignment:=taRightJustify;
   lbl_adhesion_total.caption := '';
   pnl_btn_page.Hide;
   btn_line_detail.Hide;
   btn_line_edit.hide;
   pnl_btn_ligne.visible := NOT affi;
end;

procedure Tf_adherent_list.btn_line_addClick(Sender: TObject);
begin
        pnl_btn_ligne.visible:=false;
        f_adherent_ajout.add;
end;

procedure Tf_adherent_list.btn_line_deleteClick(Sender: TObject);
begin
        f_adherent_ajout.delete;
end;

procedure  Tf_adherent_list.affi_total;
begin
   lbl_adhesion_total.caption := '  ' +floattostrF(f_adherent_list.SumColumn('theme_tarif'),FFFixed,7,2) +' €';
end;


end.

