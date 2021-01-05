unit u_gabarit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls;

type

  { Tf_gabarit }

  Tf_gabarit = class(TForm)
    item_accueil: TMenuItem;
    item_statistiques: TMenuItem;
    item_inscrit: TMenuItem;
    item_filiere: TMenuItem;
    item_quitter: TMenuItem;
    item_liste: TMenuItem;
    item_archive: TMenuItem;
    item_archive1: TMenuItem;
    item_archive2: TMenuItem;
    item_liste2: TMenuItem;
    mnu_main: TMainMenu;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    pnl_ariane: TPanel;
    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender : TObject);
    procedure choix_item_liste;
    procedure proc_accueil;

  private

  public

  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }

USES u_feuille_style,u_select_etudiant,u_accueil,u_list_inscrit,u_detail_inscription,u_modele;

procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
   item := TmenuItem(Sender);
   if item=item_liste then choix_item_liste;
   if item=item_accueil then proc_accueil;
   if item<>item_accueil then f_accueil.hide;
end;

procedure Tf_gabarit.choix_item_liste;
begin

      f_list_inscrit.borderstyle := bsNone;
      f_list_inscrit.parent := pnl_travail;
      f_list_inscrit.align := alClient;
      f_list_inscrit.init;
      f_list_inscrit.show;


      f_select_etudiant.borderstyle := bsNone;
      f_select_etudiant.parent          := pnl_selection;
      f_select_etudiant.align            := alClient;
      f_select_etudiant.init;
      f_select_etudiant.show;

      f_detail_inscription.borderstyle := bsNone;
      f_detail_inscription.parent := pnl_travail;
      f_detail_inscription.align := alClient;


end;

procedure Tf_gabarit.proc_accueil;
begin
      f_accueil.borderstyle       :=bsNone;
      f_accueil.parent            := pnl_travail;
      f_accueil.align             := alClient;
      f_accueil.show;
end;

procedure Tf_gabarit.FormShow(Sender: TObject);
begin
 style.panel_selection (pnl_ariane);
 style.panel_defaut (pnl_selection);
 style.panel_travail (pnl_travail);
 style.panel_defaut (pnl_info);
 f_gabarit.width := 1200;
 f_gabarit.height := 800;
 mnu_item_Click(item_accueil);
 modele.open;
end;


procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
 close;
end;


end.

