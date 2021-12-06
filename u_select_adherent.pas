unit u_select_adherent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_select_adherent }

  Tf_select_adherent = class(TForm)
    btn_rechercher: TButton;
    edt_code_postal: TEdit;
    edt_nom_com: TEdit;
    edt_nom_adh: TEdit;
    edt_prenom_adh: TEdit;
    edt_catsocio: TEdit;
    edt_num: TEdit;
    lbl_code_postal: TLabel;
    lbl_nom_com: TLabel;
    lbl_nom_adh: TLabel;
    lbl_prenom_adh: TLabel;
    pnl_rechercher: TPanel;
    pnl_com_btn: TPanel;
    pnl_com_edit: TPanel;
    pnl_ident_btn: TPanel;
    pnl_ident_edit: TPanel;
    pnl_catsocio_btn: TPanel;
    pnl_catsocio_edit: TPanel;
    pnl_com: TPanel;
    pnl_ident: TPanel;
    pnl_titre: TPanel;
    pnl_choix: TPanel;
    pnl_tous: TPanel;
    pnl_tous_btn: TPanel;
    pnl_tous_edit: TPanel;
    pnl_num: TPanel;
    pnl_num_btn: TPanel;
    pnl_num_edit: TPanel;
    pnl_catsocio: TPanel;
    procedure btn_rechercherClick(Sender: TObject);
    procedure Init;
    procedure NonSelectionPanel (pnl : TPanel);
    procedure AucuneSelection;
    procedure pnl_choix_btnClick (Sender: TObject);
    procedure pnl_rechercherClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_select_adherent: Tf_select_adherent;

implementation

{$R *.lfm}

uses u_feuille_style,u_list_adherent, u_modele ;

var
 pnl_actif : TPanel;

{ Tf_select_adherent }

procedure Tf_select_adherent.btn_rechercherClick(Sender: TObject);
begin
   btn_rechercher.visible := false;
   pnl_actif.enabled := false;
   if  pnl_tous_edit.Visible  then
    f_list_adherent.affi_data(modele.adherent_liste_tous)
else if  pnl_num_edit.visible  then
     f_list_adherent.affi_data(modele.adherent_liste_num(edt_num.text))
else if  pnl_catsocio_edit.visible  then
     f_list_adherent.affi_data(modele.adherent_liste_catsocio(edt_catsocio.text))
else if  pnl_ident_edit.visible  then
     f_list_adherent.affi_data(modele.adherent_liste_ident(edt_nom_adh.text,edt_prenom_adh.text))
else if pnl_com_edit.visible  then
     f_list_adherent.affi_data(modele.adherent_liste_com(edt_code_postal.text,edt_nom_com.text));
end;




{ Tf_select_adherent }

procedure Tf_select_adherent.Init;
begin
 style.panel_defaut(pnl_choix);
 style.panel_selection(pnl_titre);
 style.panel_defaut(pnl_rechercher);
 pnl_choix_btnClick (pnl_tous_btn);
end;

procedure Tf_select_adherent.pnl_choix_btnClick (Sender : TObject);
var pnl : TPanel;
begin
AucuneSelection; // retirer la sélection en cours
pnl := TPanel(Sender) ;
style.panel_selection (pnl);
pnl := TPanel(pnl.Parent); // récupération du panel parent "pnl_xxx"
style.panel_selection (pnl);
pnl := TPanel(f_select_adherent.FindComponent(pnl.name +'_edit'));
style.panel_selection (pnl);
pnl.show;
pnl_actif := pnl; pnl_actif.enabled := true;
btn_rechercher.visible := true;
end;

procedure Tf_select_adherent.pnl_rechercherClick(Sender: TObject);
begin

end;

procedure Tf_select_adherent.NonSelectionPanel (pnl : TPanel);
var pnl_enfant : TPanel;
begin
style.panel_defaut(pnl); // affectation des paramètres Fonte et Couleur du panel pnl_choix
// récupération du panel '_btn'
pnl_enfant := TPanel(f_select_adherent.FindComponent(pnl.name +'_btn'));
style.panel_bouton(pnl_enfant);
// récupération du panel '_edit'
pnl_enfant := TPanel(f_select_adherent.FindComponent(pnl.name +'_edit'));
pnl_enfant.Hide;
end;
procedure Tf_select_adherent.AucuneSelection;
begin
NonSelectionPanel (pnl_tous); NonSelectionPanel (pnl_num);
NonSelectionPanel (pnl_catsocio);
NonSelectionPanel (pnl_ident); NonSelectionPanel (pnl_com);
end;


end.

