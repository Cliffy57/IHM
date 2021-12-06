unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,u_loaddataset;
type
Tmodele = class(TMySQL)
   private
   { private declarations }
   public
   { public declarations }
   procedure open;
   function  adherent_liste_tous : TLoadDataSet;
   function  adherent_liste_num (num : string) : TLoadDataSet;
   function  adherent_liste_catsocio (v_csp_lib : string) : TLoadDataSet;
   function  adherent_liste_ident (v_adhnom, v_adhprenom : string) : TLoadDataSet;
   function  adherent_liste_com (no_com, nom_com : string) : TLoadDataSet;
   function adherent_num (num : string) : TLoadDataSet;
   function adherent_nom (num : string) : string;
   function adherent_adresse (num : string) : string;
   function adherent_ville (num : string) : string;
   function adherent_catsocio (num : string) : string;
   function adherent_mel (num : string) : string;
   function adhesion_adherent (num : string) : TLoadDataSet;
   function adherent_adhesion_tous : TLoadDataSet;
   function theme : TLoadDataSet;
   procedure adherent_delete (num : string);
   procedure adherent_insert (adh_num, csp_num, adh_nom, adh_prenom, adh_cp,adh_ville,adh_adr,adh_mel,adh_civ : string);
   procedure adherent_update (adh_num, csp_num, adh_nom, adh_prenom, adh_cp ,adh_ville ,adh_adr ,adh_mel,adh_civ: string);
   procedure adherent_adhesion_delete (id_adh : string);
   procedure adherent_adhesion_insert (id_adh, theme_num : string);

   procedure close;
end;

var
     modele: Tmodele;
implementation

procedure Tmodele.open;
begin
      Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0
		, 'dipaolo6u_clubadh'
		, 'dipaolo6u_appli'
		, 'Ldip2006'
		, 'mysqld-5', 'libmysql64.dll');
end;

procedure Tmodele.close;
begin
      Bd_close;
end;

// tous les adherents
function Tmodele.adherent_liste_tous : TLoadDataSet;
begin
     result := load('sp_adherent_liste_tous',[]);
end;

// adherent id_adh=num
function Tmodele.adherent_liste_num (num : string) : TLoadDataSet;
begin
     result := load('sp_adherent_liste_num',[num]);
end;


// adhesiosn qui concernent les adherent dont le n°  contient la valeur contenue dans no_adh
// ou le nom du conducteur contient la valeur contenue dans nom
function Tmodele.adherent_liste_ident (v_adhnom, v_adhprenom : string) : TLoadDataSet;
begin
      result := load('sp_adherent_liste_ident',[v_adhnom, v_adhprenom]);
end;

// adhesions qui concernent la categorie sociale
function Tmodele.adherent_liste_catsocio (v_csp_lib : string) : TLoadDataSet;
begin
      result := load('sp_adherent_liste_catsocio',[v_csp_lib]);
end;

// adhesions commises dans les communes dont le n° de commune contient la valeur contenue dans noo_com
// ou  le nom contient la valeur contenue dans nom_com
function Tmodele.adherent_liste_com (no_com, nom_com : string) : TLoadDataSet;
begin
      result := load('sp_adherent_liste_com',[no_com, nom_com]);
end;

function Tmodele.theme () : TLoadDataSet;
begin
      result := load('sp_theme_tous',[]);
end;

function Tmodele.adherent_num (num : string) : TLoadDataSet;
begin
 result := load('sp_adherent_num',[num]);
end;

function Tmodele.adherent_nom (num : string) : string;
begin
 load('sp_adherent_nom',[num], result);
end;

function Tmodele.adherent_adresse (num : string) : string;
begin
 load('sp_adherent_adresse',[num], result);
end;

function Tmodele.adherent_ville (num : string) : string;
begin
 load('sp_adherent_ville',[num], result);
end;
function Tmodele.adherent_catsocio (num : string) : string;
begin
 load('sp_adherent_categsocio',[num], result);
end;

function Tmodele.adherent_mel (num : string) : string;
begin
 load('sp_adherent_mel',[num], result);
end;

function Tmodele.adhesion_adherent  (num : string) : TLoadDataSet;
begin
 result := load('sp_adhesion_adherent',[num]);
end;

function Tmodele.adherent_adhesion_tous : TLoadDataSet;
begin
 result := load('sp_adhesion_tous',[]);
end;
procedure Tmodele.adherent_delete (num : string);
begin
 exec('sp_adherent_delete',[num]);
end;

procedure Tmodele.adherent_insert (adh_num, csp_num, adh_nom, adh_prenom, adh_cp,adh_ville,adh_adr,adh_mel,adh_civ : string);
begin
 exec('sp_adherent_insert',[adh_num, csp_num, adh_nom, adh_prenom, adh_cp,adh_ville,adh_adr,adh_mel,adh_civ]);
end;

procedure Tmodele.adherent_update (adh_num, csp_num, adh_nom, adh_prenom, adh_cp ,adh_ville ,adh_adr ,adh_mel ,adh_civ: string);
begin
 exec('sp_adherent_update',[adh_num], [csp_num, adh_nom, adh_prenom, adh_cp, adh_ville ,adh_adr ,adh_mel,adh_civ]);
end;

procedure Tmodele.adherent_adhesion_delete (id_adh : string);
begin
 exec('sp_adherent_adhesion_delete',[id_adh]);
end;

procedure Tmodele.adherent_adhesion_insert (id_adh, theme_num : string);
begin
 exec('sp_adherent_adhesion_insert',[id_adh, theme_num]);
end;

begin
     modele := TModele.Create;
end.


