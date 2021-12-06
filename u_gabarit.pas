unit u_gabarit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls;

type

  { Tf_gabarit }

  Tf_gabarit = class(TForm)
    item_accueil: TMenuItem;
    item_quitter: TMenuItem;
    item_liste: TMenuItem;
    item_stat: TMenuItem;
    item_adherent: TMenuItem;
    item_tarif: TMenuItem;
    lbl_titre: TLabel;
    mnu_main: TMainMenu;
    pnl_ariane: TPanel;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure pnl_infoClick(Sender: TObject);
    procedure pnl_selectionClick(Sender: TObject);
    procedure pnl_travailClick(Sender: TObject);
    procedure choix_item_liste;
    procedure choix_item_acceuil;


  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }

uses u_feuille_style,u_list_adherent,u_select_adherent, u_detail_adherent ,u_modele,u_acceuil;




procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.Caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
   item := TmenuItem(Sender);
   if item=item_liste then choix_item_liste;


end;

procedure Tf_gabarit.pnl_infoClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.choix_item_acceuil;
begin
f_gabarit.borderstyle := bsNone;
f_gabarit.parent := pnl_travail;
f_gabarit.align := alClient;
pnl_selection.Caption:='';
pnl_travail.Caption :='';
pnl_info.Caption:='';
f_list_adherent.hide;
f_detail_adherent.hide;
f_select_adherent.hide;
f_acceuil.borderstyle := bsNone;
f_acceuil.parent := pnl_travail;
f_acceuil.align := alClient;
f_acceuil.init;
f_acceuil.show;
end;

procedure Tf_gabarit.choix_item_liste;
begin

 f_list_adherent.borderstyle := bsNone;
 f_list_adherent.parent := pnl_travail;
 f_list_adherent.align := alClient;
 f_list_adherent.init;
 f_list_adherent.show ;


 f_select_adherent.borderstyle := bsNone;
 f_select_adherent.parent := pnl_selection;
 f_select_adherent.align := alClient;
 f_select_adherent.init;
 f_select_adherent.show;

 f_detail_adherent.borderstyle := bsNone;
 f_detail_adherent.parent := pnl_travail;
 f_detail_adherent.align := alClient;
end;


procedure Tf_gabarit.pnl_selectionClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.pnl_travailClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.FormCreate(Sender: TObject);
begin

end;

procedure Tf_gabarit.FormShow(Sender: TObject);
begin
   style.panel_selection (pnl_ariane);
   style.panel_defaut    (pnl_selection);
   style.panel_travail   (pnl_travail);
   style.panel_defaut    (pnl_info);
   f_gabarit.width := 1200;
   f_gabarit.height :=  800;
   f_acceuil.align := alClient;
   f_acceuil.parent := pnl_travail;
   f_acceuil.borderstyle := bsNone;
   f_acceuil.init;
   f_acceuil.show;
   pnl_selection.Caption:='';
   pnl_travail.Caption :='';
   pnl_info.Caption:='';
   pnl_ariane.Caption:=' >Accueil';
   modele.open;
end;

procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
   modele.close;
   close;
end;

end.

