unit u_select_etudiant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_select_etudiant }

  Tf_select_etudiant = class(TForm)
    btn_rechercher: TButton;
    edt_code: TEdit;
    edt_nom: TEdit;
    edt_numero: TEdit;
    lbl_code: TLabel;
    lbl_nom: TLabel;
    lbl_numero: TLabel;
    pnl_rechercher: TPanel;
    pnl_filiere_edit: TPanel;
    pnl_filiere_btn: TPanel;
    pnl_filiere: TPanel;
    pnl_etudiant_edit: TPanel;
    pnl_etudiant_btn: TPanel;
    pnl_etudiant: TPanel;
    pnl_tous_edit: TPanel;
    pnl_tous_btn: TPanel;
    pnl_tous: TPanel;
    pnl_titre: TPanel;
    pnl_choix: TPanel;
    procedure btn_rechercherClick(Sender: TObject);
    procedure Init;
    procedure NonSelectionPanel (pnl : TPanel);
    procedure AucuneSelection;
    procedure pnl_choix_btnClick (Sender: TObject);

  private

  public

  end;

var
  f_select_etudiant: Tf_select_etudiant;

implementation

{$R *.lfm}
uses u_feuille_style,u_list_inscrit, u_modele ;

{ Tf_select_etudiant }

var
 pnl_actif : TPanel;

procedure Tf_select_etudiant.btn_rechercherClick(Sender: TObject);
begin
  btn_rechercher.visible := false;
  pnl_actif.enabled := false;
  if pnl_tous_edit.Visible then
       f_list_inscrit.affi_data(modele.inscription_liste_tous)
  else if pnl_etudiant_edit.visible then
       f_list_inscrit.affi_data(modele.inscription_liste_etu(edt_numero.text,edt_nom.text))
  else if pnl_filiere_edit.visible then
       f_list_inscrit.affi_data(modele.inscription_liste_filiere(edt_code.text))
end;


procedure Tf_select_etudiant.Init;
begin
    style.panel_defaut (pnl_choix);
    style.panel_selection (pnl_titre);
    style.panel_defaut(pnl_rechercher);
    pnl_choix_btnClick (pnl_tous_btn);
end;

procedure   Tf_select_etudiant.pnl_choix_btnClick (Sender : TObject);
var
   pnl : TPanel;
begin
   AucuneSelection;
   pnl := TPanel(Sender);
   style.panel_selection (pnl);
   pnl	:= TPanel(pnl.Parent);	style.panel_selection (pnl);
   pnl	:= TPanel(f_select_etudiant.FindComponent(pnl.name +'_edit'));
   style.panel_selection (pnl);
   pnl.show;
   pnl_actif := pnl;     pnl_actif.enabled := true;
   btn_rechercher.visible := true;
end;

procedure  Tf_select_etudiant.NonSelectionPanel (pnl : TPanel);
var
	pnl_enfant : TPanel;
begin
	style.panel_defaut(pnl);
	pnl_enfant	:= TPanel(f_select_etudiant.FindComponent(pnl.name +'_btn'));
	style.panel_bouton(pnl_enfant);
	pnl_enfant	:= TPanel(f_select_etudiant.FindComponent(pnl.name +'_edit'));
	pnl_enfant.Hide;
end;

procedure   Tf_select_etudiant.AucuneSelection;
begin
	NonSelectionPanel (pnl_tous);		NonSelectionPanel (pnl_etudiant);
	NonSelectionPanel (pnl_filiere);
end;

end.

