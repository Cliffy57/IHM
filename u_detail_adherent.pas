unit u_detail_adherent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_detail_adherent }

  Tf_detail_adherent = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    cbo_civ: TComboBox;
    edt_numcatsocio: TEdit;
    edt_mel: TEdit;
    edt_ville: TEdit;
    edt_codepost: TEdit;
    edt_adresse: TEdit;
    edt_prenom: TEdit;
    edt_nom: TEdit;
    edt_num: TEdit;
    lbl_coord_erreur: TLabel;
    lbl_catsocio_erreur: TLabel;
    lbl_mel_erreur: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_num_erreur: TLabel;
    lbl_adhesion: TLabel;
    lbl_adhesion_erreur: TLabel;
    lbl_numcatsocio: TLabel;
    lbl_catsocio: TLabel;
    lbl_mel: TLabel;
    lbl_adresse: TLabel;
    lbl_coord: TLabel;
    lbl_num: TLabel;
    lbl_ident: TLabel;
    mmo_catsocio: TMemo;
    pnl_adhesion_ajout: TPanel;
    pnl_adhesion_list: TPanel;
    pnl_adhesion_titre: TPanel;
    pnl_adhesion: TPanel;
    pnl_catsocio: TPanel;
    pnl_coord: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure btn_validerClick(Sender: TObject);
    procedure cbo_civChange(Sender: TObject);
    procedure edt_adresseExit(Sender: TObject);
    procedure edt_codepostExit(Sender: TObject);
    procedure edt_melExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_numcatsocioExit(Sender: TObject);
    procedure edt_numEnter(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure init ( idadh : string; affi : boolean);
    procedure detail ( idadh : string);
    procedure edit ( idadh : string);
    procedure add;
    procedure delete ( idadh : string);
    procedure edt_Enter (Sender : TObject );
    procedure pnl_adhesion_ajoutClick(Sender: TObject);

  private
    procedure affi_page;
    procedure affi_ident(num : string);
    procedure affi_coord (num : string);
    procedure affi_catsocio (num : string);
    procedure affi_ville (num : string);
    function affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;

  public
    { public declarations }
  end;

var
  f_detail_adherent: Tf_detail_adherent;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_adherent,u_adherent_list, u_adherent_ajout ,u_modele, u_loaddataset ;

{ Tf_detail_adherent }

Var
   oldvaleur  : string;	// utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
   id  : string;	// variable active dans toute l'unité, contenant l'id adhesion affichée

procedure	Tf_detail_adherent.Init   ( idadh : string;	affi : boolean);
//  ajout nouvelle adhesion : id est vide
// affichage détail d'une adhesion : affi est vrai sinon affi est faux
begin
   style.panel_travail	(pnl_titre);
   style.panel_travail	(pnl_btn);
   style.panel_travail	(pnl_detail);
	style.panel_travail (pnl_ident);
		style.label_titre  (lbl_ident);
		style.label_erreur (lbl_num_erreur);		lbl_num_erreur.caption    :=  '  ' ;
		style.label_erreur (lbl_nom_erreur);		lbl_nom_erreur.caption  :=  '  ' ;
		style.label_erreur (lbl_prenom_erreur);		lbl_prenom_erreur.caption  :=  '  ' ;
	style.panel_travail (pnl_coord);
		style.label_titre  (lbl_coord);
		style.label_erreur (lbl_mel_erreur);		lbl_mel_erreur.caption  :=  '  ' ;
	style.panel_travail (pnl_catsocio);
		style.label_titre  (lbl_catsocio);			style.memo_info  (mmo_catsocio);
		style.label_erreur (lbl_catsocio_erreur);		lbl_catsocio_erreur.caption :=  '  ' ;

   	style.panel_travail (pnl_adhesion);
	style.panel_travail (pnl_adhesion_titre);
		style.label_titre  (lbl_adhesion);
		style.label_erreur (lbl_adhesion_erreur);		lbl_adhesion_erreur.caption :=  '  ' ;
	style.panel_travail (pnl_adhesion_list);
	style.panel_travail (pnl_adhesion_ajout);

   edt_num.ReadOnly	:=affi;
// initialisation ident
   lbl_num_erreur.caption	:='';
   edt_num.clear;
   edt_num.ReadOnly	:=affi;
// initialisation coord
   lbl_mel_erreur.caption	:='';
   edt_adresse.clear;
   edt_adresse.ReadOnly		:=affi;
// initialisation catsocio
   lbl_catsocio_erreur.caption	:='';
   edt_numcatsocio.clear;
   edt_numcatsocio.ReadOnly		:=affi;
   mmo_catsocio.clear;
   mmo_catsocio.ReadOnly	:=true;
   btn_retour.visible	:=affi;  // visible quand affichage détail
   btn_valider.visible	:=NOT  affi;    // visible quand ajout/modification adhesion
   btn_annuler.visible	:=NOT  affi;    // visible quand ajout/modification adhesion


   f_adherent_list.affi_data(modele.adhesion_adherent(idadh));
   f_adherent_list.affi_total;


// initialisation adhesion
   lbl_adhesion_erreur.Caption  :='';
   f_adherent_list.borderstyle	      := bsNone;
   f_adherent_list.parent	      := pnl_adhesion_list;
   f_adherent_list.align	      := alClient;
   f_adherent_list.init(affi);
   f_adherent_list.show;
   f_adherent_ajout.borderstyle   := bsNone;
   f_adherent_ajout.parent	      := pnl_adhesion_ajout;
   f_adherent_ajout.align	      := alClient;



   id  := idadh;
   IF  NOT  ( id = '')   // affichage/modification adhesion
   THEN  affi_page;

   f_adherent_list.affi_data(modele.adhesion_adherent(id));
   f_adherent_list.affi_total;

   show;

end;
procedure Tf_detail_adherent.affi_ident (num : string);
var
   ch : string;
begin
   lbl_num.visible := false;
   if  num = ''
   then  lbl_num_erreur.visible := true;


end;

procedure Tf_detail_adherent.affi_coord (num : string);
var
   ch : string;
begin
   if  num = ''
   then  lbl_mel_erreur.visible := true;


end;

procedure Tf_detail_adherent.affi_catsocio (num : string);
var
   ch : string;
begin
   if  num = ''
   then  lbl_catsocio_erreur.visible := true;

end;
procedure Tf_detail_adherent.affi_ville (num : string);
var
   ch : string;
begin
   if  num = ''
   then begin lbl_coord_erreur.visible := true;   end

   else   lbl_coord_erreur.visible := false;


end;

function Tf_detail_adherent.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
 lbl.caption := erreur;
 if NOT (erreur = '')
 then begin
 edt.setFocus;
 result := false;
 end
 else result := true;
end;
procedure	Tf_detail_adherent.affi_page;
var
 flux : TLoadDataSet;
begin
flux := modele.adherent_num(id);
flux.read;
edt_num.text := flux.Get('adh_num');
edt_codepost.text := flux.Get('adh_cp');
edt_numcatsocio.text := flux.Get('csp_num');
edt_ville.text := flux.Get('adh_ville');
edt_nom.text := flux.Get('adh_nom');
edt_prenom.text :=flux.Get('adh_prenom');
edt_mel.text :=flux.Get('adh_mel');
edt_adresse.text := flux.Get('adh_adr');
mmo_catsocio.text := flux.Get('csp_lib');
cbo_civ.text := flux.Get('adh_civ');
flux.destroy;

affi_ident (edt_num.text);            //vehicule , conducteur,commune
affi_coord (edt_codepost.text);
affi_catsocio (edt_numcatsocio.text);
affi_ville (edt_ville.text);
end;

procedure	Tf_detail_adherent.detail (idadh : string);
begin
   init (idadh, true);    // mode affichage
   pnl_titre.caption	:= 'Détail d''une adhesion';
   btn_retour.setFocus;
end;

procedure	Tf_detail_adherent.edit (idadh : string);
begin
   init (idadh, false);
   pnl_titre.caption	:= 'Modification d''une adhesion';
   edt_num.ReadOnly	 := true;
end;

procedure  Tf_detail_adherent.add;
begin
   init ('',false);   // pas de numéro d'adherent
   pnl_titre.caption   := 'Nouvelle adhesion';
   edt_num.setFocus;
end;

procedure Tf_detail_adherent.delete (idadh : string);
begin
   IF   messagedlg ('Demande de confirmation'
	,'Confirmez-vous la suppression de l''adhesion n°' +idadh
	,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
   THEN  BEGIN
         modele.adherent_adhesion_delete (idadh);
         modele.adherent_delete (idadh);
               f_list_adherent.line_delete;
   END;
end;

procedure Tf_detail_adherent.btn_retourClick(Sender: TObject);
begin
  close;
end;

procedure Tf_detail_adherent.btn_validerClick(Sender: TObject);
  var
    flux	     : TLoadDataSet;
    saisie, erreur, ch	 : string;
    i 	     : integer;
    valide  : boolean;
begin
    valide := true;

    erreur := '';
    if  f_adherent_list.sg_liste.RowCount = 1
    then  begin
              erreur := 'L''adhesion doit être renseignée.';
              valide := false;
    end;
    lbl_adhesion_erreur.caption := erreur;

    erreur := '';
    saisie := edt_codepost.text;
    if  saisie = ''  then  erreur := 'Le numéro doit être rempli.'
    else  begin
             ch := modele.adherent_adresse(saisie);
	  if  ch = ''  then erreur := 'numéro inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_coord_erreur, edt_codepost)  AND  valide;

    erreur := '';
   saisie := edt_num.text;
    if  NOT (saisie = '')
    then  begin
            flux  := modele.adherent_num(saisie);
             if NOT flux.endOf
             then  erreur := 'numéro inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num)  AND  valide;

    erreur := '';
    saisie := edt_nom.text;
    if  saisie = ''  then  erreur := 'Le nom doit être rempli.'
    else  begin
             ch := modele.adherent_nom(saisie);
	  if  ch = ''  then erreur := 'Le nom n''existe pas.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_nom_erreur, edt_nom)  AND  valide;

    erreur := '';
    saisie := edt_prenom.text;
    if  saisie = ''  then  erreur := 'Le prenom doit être rempli.'
    else  begin
             ch := modele.adherent_nom(saisie);
	  if  ch = ''  then erreur := 'Le prenom est inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_prenom_erreur, edt_prenom)  AND  valide;

      erreur := '';
    saisie := edt_numcatsocio.text;
    if  saisie = ''  then  erreur := 'categorie non renseigne'
    else  begin
             ch := modele.adherent_nom(saisie);
	  if  ch = ''  then erreur := 'La categorie sociale existe deja';
    end;
    valide := affi_erreur_saisie (erreur, lbl_catsocio_erreur, edt_numcatsocio)  AND  valide;

    erreur := '';
    saisie := edt_mel.text;
    if  saisie = ''  then  erreur := 'L''adresse mel doit etre remplie.'
    else  begin
             ch := modele.adherent_nom(saisie);
	  if  ch = ''  then erreur := 'Le mel existe deja';
    end;
    valide := affi_erreur_saisie (erreur, lbl_mel_erreur, edt_mel)  AND  valide;








    if  id = ''
    then begin
	 erreur := '';
	 saisie := edt_num.text;
	 if  saisie = ''   then  erreur := 'Le numéro doit être rempli.'
	 else begin
	      flux := modele.adherent_liste_num(saisie);
	      if  NOT  flux.endOf
	      then  erreur := 'Le numéro existe déjà';
	 end;
	 valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num)  AND  valide;
    end;

    if  NOT  valide
    then  messagedlg ('Erreur enregistrement Adherent', 'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.', mtWarning, [mbOk], 0)
    else  begin
          if  id =''
	  then  modele.adherent_insert(edt_num.text, edt_numcatsocio.text, edt_nom.text, edt_prenom.text, edt_codepost.text,edt_ville.text, edt_adresse.text,edt_mel.text,cbo_civ.text)
	  else  begin
		modele.adherent_update(id, edt_numcatsocio.text, edt_nom.text, edt_prenom.text, edt_codepost.text ,edt_ville.text ,edt_mel.text,edt_adresse.text,cbo_civ.text);
	     // suppression de la composition de l'adhesion
		modele.adherent_adhesion_delete (edt_num.text);
	  end;

          i := 1;   // commence à 1 pour passer la ligne de titres des colonnes en ligne 0
   	  while  ( i  <  f_adherent_list.sg_liste.RowCount )
   	  do  begin
              modele.adherent_adhesion_insert (edt_num.text, f_adherent_list.sg_liste.Cells[0,i]);
              i := i +1;
          end;

	  if id='' then f_list_adherent.line_add(modele.adherent_liste_num(edt_num.text))
   	  else f_list_adherent.line_edit(modele.adherent_liste_num(id));
   	  close;
    end;
end;

procedure Tf_detail_adherent.cbo_civChange(Sender: TObject);
begin

end;

procedure Tf_detail_adherent.edt_adresseExit(Sender: TObject);
begin
   edt_adresse.text := TRIM(edt_adresse.text);
  IF NOT ( edt_adresse.text = oldvaleur )
  THEN affi_coord (edt_adresse.text);
end;

procedure Tf_detail_adherent.edt_codepostExit(Sender: TObject);
begin
   edt_codepost.text := TRIM(edt_codepost.text);
  IF NOT ( edt_codepost.text = oldvaleur )
  THEN affi_coord (edt_codepost.text);
end;

procedure Tf_detail_adherent.edt_melExit(Sender: TObject);
begin
  edt_mel.text := TRIM(edt_mel.text);
  IF NOT ( edt_mel.text = oldvaleur )
  THEN affi_coord (edt_mel.text);
end;

procedure Tf_detail_adherent.edt_nomExit(Sender: TObject);
begin
  edt_nom.text := TRIM(edt_nom.text);
  IF NOT ( edt_nom.text = oldvaleur )
  THEN affi_ident (edt_nom.text);
end;

procedure Tf_detail_adherent.edt_numcatsocioExit(Sender: TObject);
begin
   edt_numcatsocio.text := TRIM(edt_numcatsocio.text);
  IF NOT ( edt_numcatsocio.text = oldvaleur )
  THEN affi_catsocio(edt_numcatsocio.text);
end;

procedure Tf_detail_adherent.edt_numEnter(Sender: TObject);
begin

end;

procedure Tf_detail_adherent.edt_numExit(Sender: TObject);
begin
  edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_adherent.edt_prenomExit(Sender: TObject);
begin
   edt_prenom.text := TRIM(edt_prenom.text);
  IF NOT ( edt_prenom.text = oldvaleur )
  THEN affi_ident (edt_prenom.text);
end;


procedure Tf_detail_adherent.btn_annulerClick(Sender: TObject);
begin
  close;
end;

procedure Tf_detail_adherent.edt_Enter(Sender :TObject);
begin
oldvaleur := TEdit(Sender).text;
end;

procedure Tf_detail_adherent.pnl_adhesion_ajoutClick(Sender: TObject);
begin

end;

end.

