unit u_detail_inscription;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids;

type

  { Tf_detail_inscription }

  Tf_detail_inscription = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    edt_filiere: TComboBox;
    edt_prenom: TEdit;
    edt_mel: TEdit;
    edt_portable: TEdit;
    edt_telephone: TEdit;
    edt_ville: TEdit;
    edt_codepostal: TEdit;
    edt_adresse: TEdit;
    edt_nom: TEdit;
    edt_genre: TComboBox;
    edt_num: TEdit;
    lbl_relvnote_erreur: TLabel;
    lbl_contact_erreur: TLabel;
    lbl_filiere_erreur: TLabel;
    lbl_adresse_erreur: TLabel;
    lbl_adresse: TLabel;
    lbl_moy_fil: TLabel;
    lbl_moy_filiere: TLabel;
    lbl_moy_etu: TLabel;
    lbl_note_titre: TLabel;
    lbl_filiere: TLabel;
    lbl_mel: TLabel;
    lbl_portable: TLabel;
    lbl_telephone: TLabel;
    lbl_contact: TLabel;
    lbl_prenom: TLabel;
    lbl_nom: TLabel;
    lbl_num_erreur: TLabel;
    lbl_ident: TLabel;
    lbl_num: TLabel;
    pnl_relv_note: TPanel;
    pnl_note_titre: TPanel;
    pnl_note: TPanel;
    pnl_filiere: TPanel;
    pnl_contact: TPanel;
    pnl_adresse: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_titre: TPanel;
    pnl_btn: TPanel;
    sg_note: TStringGrid;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure edt_adresseExit(Sender: TObject);
    procedure edt_codepostalExit(Sender: TObject);
    procedure edt_melExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_portableExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure edt_telephoneExit(Sender: TObject);
    procedure edt_villeExit(Sender: TObject);
    procedure init ( idinf : string; affi : boolean);
    procedure detail ( idinf : string);
    procedure edit ( idinf : string);
    procedure edt_Enter (Sender : TObject );
    procedure add;
    procedure delete ( idinf : string);
    function affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;

  private
    procedure affi_page;
  public

  end;

var
  f_detail_inscription: Tf_detail_inscription;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_inscrit;


{ Tf_detail_inscription }

Var oldvaleur : string; // utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
id : string; // variable active dans toute l'unité, contenant l'id infraction affichée

procedure Tf_detail_inscription.Init ( idinf : string; affi : boolean);
// ajout nouvelle inscription : id est vide
// affichage détail d'une inscription : affi est vrai sinon affi est faux
begin
     style.panel_travail (pnl_titre);
     style.panel_travail (pnl_btn);
     style.panel_travail (pnl_detail);
     style.panel_travail (pnl_ident);
     style.label_titre (lbl_ident);
     style.label_erreur (lbl_num_erreur); lbl_num_erreur.caption := '' ;
     style.panel_travail (pnl_adresse);
     style.label_titre (lbl_adresse);
     style.label_erreur (lbl_adresse_erreur); lbl_adresse_erreur.caption := '' ;
     style.panel_travail (pnl_contact);
     style.label_titre (lbl_contact);
     style.label_erreur (lbl_contact_erreur); lbl_contact_erreur.caption := '' ;
     style.panel_travail (pnl_filiere);
     style.label_titre (lbl_filiere);
     style.label_erreur (lbl_filiere_erreur); lbl_filiere_erreur.caption := '' ;
     style.panel_travail (pnl_note);
     style.panel_travail (pnl_note_titre);
     style.label_titre (lbl_note_titre);
     style.panel_travail (pnl_relv_note);
// initialisation identification
     lbl_num_erreur.caption :='';
     edt_num.clear;
     edt_num.ReadOnly :=affi;
     edt_nom.clear;
     edt_nom.ReadOnly :=affi;
     edt_prenom.clear;
     edt_prenom.ReadOnly :=affi;
     //réflechir à edt_genre

 // initialisation Adresse
     lbl_adresse_erreur.caption := '';
     edt_adresse.clear;
     edt_adresse.ReadOnly :=affi;
     edt_codepostal.clear;
     edt_codepostal.ReadOnly :=affi;
     edt_ville.clear;
     edt_ville.ReadOnly :=affi;

// initialisation contact
     lbl_contact_erreur.caption :='';
     edt_telephone.clear;
     edt_telephone.ReadOnly :=affi;
     edt_portable.clear;
     edt_portable.ReadOnly :=true;
     edt_mel.clear;
     edt_mel.ReadOnly :=true;

// initialisation filière
     lbl_filiere_erreur.caption := '';
     edt_filiere.Clear;
     edt_filiere.ReadOnly := affi;
     btn_retour.visible :=affi; // visible quand affichage détail
     btn_valider.visible :=NOT affi; // visible quand ajout/modification infraction
     btn_annuler.visible :=NOT affi; // visible quand ajout/modification infraction
// initialisation amende
     lbl_relvnote_erreur.Caption :='';
     show;
end;



procedure Tf_detail_inscription.btn_retourClick(Sender: TObject);
begin
  close;
end;

procedure Tf_detail_inscription.edt_adresseExit(Sender: TObject);
begin
  edt_adresse.text := TRIM(edt_adresse.text);
end;

procedure Tf_detail_inscription.edt_codepostalExit(Sender: TObject);
begin
  edt_codepostal.text := TRIM(edt_codepostal.text);
end;

procedure Tf_detail_inscription.edt_melExit(Sender: TObject);
begin
   edt_mel.text := TRIM(edt_mel.text);
end;

procedure Tf_detail_inscription.edt_nomExit(Sender: TObject);
begin
  edt_nom.text := TRIM(edt_nom.text);
end;

procedure Tf_detail_inscription.edt_numExit(Sender: TObject);
begin
  edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_inscription.edt_portableExit(Sender: TObject);
begin
   edt_portable.text := TRIM(edt_portable.text);
end;

procedure Tf_detail_inscription.edt_prenomExit(Sender: TObject);
begin
  edt_prenom.text := TRIM(edt_prenom.text);
end;

procedure Tf_detail_inscription.edt_telephoneExit(Sender: TObject);
begin
   edt_telephone.text := TRIM(edt_telephone.text);
end;

procedure Tf_detail_inscription.edt_villeExit(Sender: TObject);
begin
   edt_ville.text := TRIM(edt_ville.text);
end;

procedure Tf_detail_inscription.btn_annulerClick(Sender: TObject);
begin
  close;
end;

 procedure Tf_detail_inscription.affi_page;
begin
// affichage des données de la base, complété par la suite
end;

procedure Tf_detail_inscription.detail (idinf : string);
begin
     init (idinf, true); // mode affichage
     pnl_titre.caption := 'Détail d''une inscription';
     btn_retour.setFocus;
end;

procedure Tf_detail_inscription.edit (idinf : string);
begin
     init (idinf, false);
     pnl_titre.caption := 'Modification d''une inscription';
     edt_num.ReadOnly := true;
end;

procedure Tf_detail_inscription.edt_Enter(Sender : TObject);
begin
     oldvaleur := TEdit(Sender).text;
end;


procedure Tf_detail_inscription.add;
begin
     init ('',false); // pas de numéro d'inscription
     pnl_titre.caption := 'Nouvelle inscription';
     edt_num.setFocus;
     edt_genre.ItemIndex:=0;
end;

procedure Tf_detail_inscription.delete (idinf : string);
begin
     IF messagedlg ('Demande de confirmation','Confirmez-vous la suppression de l''infraction n°' +idinf,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
     THEN BEGIN

// suppression dans la base, complété par la suite
     //Tf_detail_inscription.line_delete;
END;
end;

function Tf_detail_inscription.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
     lbl.caption := erreur;
     if NOT (erreur = '')
     then begin
     edt.setFocus;
     result := false;
     end
     else result := true;
end;


end.

