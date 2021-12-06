unit u_adherent_ajout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_adherent_ajout }

  Tf_adherent_ajout = class(TForm)
    cbo_adhesion_theme: TComboBox;
    pnl_detail: TPanel;
    pnl_titre: TPanel;
    procedure cbo_adhesion_themeCloseUp(Sender: TObject);
    procedure Init;
    procedure add;
    procedure delete;
    procedure add_adhesion_to_adherent (cle : string; cbo : TComboBox);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_adherent_ajout: Tf_adherent_ajout;

implementation

{$R *.lfm}

{ Tf_adherent_ajout }


uses   u_feuille_style, u_adherent_list,u_modele, u_loaddataset ;
var
 flux_adhesion : TLoadDataSet ;

procedure Tf_adherent_ajout.Init;
begin
   style.panel_selection (pnl_titre);
   style.panel_travail  (pnl_detail);
         style.combo (cbo_adhesion_theme);
   cbo_adhesion_theme.Clear;
   flux_adhesion := modele.theme;
end;

procedure Tf_adherent_ajout.cbo_adhesion_themeCloseUp(Sender: TObject);
begin
  add_adhesion_to_adherent ('theme_lib',cbo_adhesion_theme);
end;

procedure Tf_adherent_ajout.delete;
begin
   f_adherent_list.line_delete;
   f_adherent_list.affi_total;
end;


procedure Tf_adherent_ajout.add;
var   i : integer;
begin
   init;
     //cbo_adhesion_num.items := flux_adhesion.Column('num');
   i := cbo_adhesion_theme.Items.Count;
    cbo_adhesion_theme.items := flux_adhesion.Column('theme_lib');
   while (i > 0)
   do begin
         i := i -1;
         if  f_adherent_list.sg_liste.Cols[0].IndexOf(cbo_adhesion_theme.items[i]) > -1
         then cbo_adhesion_theme.Items.Delete(i);
   end;
   show;
end;

procedure Tf_adherent_ajout.add_adhesion_to_adherent (cle : string; cbo : TComboBox);
begin
   if cbo.ItemIndex > -1
   then begin
        flux_adhesion.Position (cle,cbo.items[cbo.itemindex]);
         // T := flux_adhesion.Read;
         // f_adherent_list.line_add(['num',T.Valeur['num'],'designation',T.Valeur['designation']
         // , 'tarif', T.valeur['tarif']]);
         f_adherent_list.line_add(flux_adhesion.Read);
            f_adherent_list.affi_total;
   end;
   f_adherent_list.pnl_btn_ligne.visible := true;
   close;
end;

end.

