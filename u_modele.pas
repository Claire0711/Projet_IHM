unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_loaddataset;

type
Tmodele = class(TMySQL)
   private
   { private declarations }
   public
   { public declarations }
        procedure open;
        function inscription_liste_tous : TLoadDataSet;
        function inscription_liste_etu (num, nom : string) : TLoadDataSet;
        function inscription_liste_filiere (code: string) : TLoadDataSet;
        function inscription_num (num : string) : TLoadDataSet;
        function inscription_filiere (num : string) : string;

        procedure close;
end;
var
     modele: Tmodele;
implementation

procedure Tmodele.open;
begin
      Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0
		, 'thil32u_bdnote'
		, 'thil32u_appli'
		, '07112001ClaireT'
		, 'mysqld-5', 'libmysql64.dll');
end;

procedure Tmodele.close;
begin
      Bd_close;
end;

// toutes les inscription
function Tmodele.inscription_liste_tous : TLoadDataSet;
begin
     result := load('sp_inscription_liste_tous',[]);
end;

// inscription id_inf=num
function Tmodele.inscription_liste_etu (num,nom : string) : TLoadDataSet;
begin
     result := load('sp_inscription_liste_etu',[num,nom]);
end;

// infractions code= code
function Tmodele.inscription_liste_filiere (code : string) : TLoadDataSet;
begin
     result := load('sp_inscription_liste_filiere',[code]);
end;

function Tmodele.inscription_num (num : string) : TLoadDataSet;
begin
 result := load('sp_inscription_num',[num]);
end;

function Tmodele.inscription_filiere (num : string) : string;
begin
 load('sp_inscription_filiere',[num], result);
end;



begin
     modele := TModele.Create;
end.

