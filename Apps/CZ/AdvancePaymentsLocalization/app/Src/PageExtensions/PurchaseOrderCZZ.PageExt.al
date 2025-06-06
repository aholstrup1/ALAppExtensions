﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Finance.AdvancePayments;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.Posting;

pageextension 31037 "Purchase Order CZZ" extends "Purchase Order"
{
    layout
    {
        modify(Prepayment)
        {
            Visible = false;
        }
        addlast(General)
        {
            field("Unpaid Advance Letter CZZ"; Rec."Unpaid Advance Letter CZZ")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies if unpaid advance letter exists for this order.';
                Visible = false;
            }
        }
        addlast(factboxes)
        {
#if not CLEAN25
            part("Purch. Adv. Usage FactBox CZZ"; "Purch. Adv. Usage FactBox CZZ")
            {
                ApplicationArea = Basic, Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced by "Advance Usage FactBox CZZ"';
                ObsoleteTag = '25.0';
            }
#endif
            part(AdvanceUsageFactBoxCZZ; "Advance Usage FactBox CZZ")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        modify(PostedPrepaymentInvoices)
        {
            Visible = false;
        }
        modify(PostedPrepaymentCrMemos)
        {
            Visible = false;
        }
        modify("Prepa&yment")
        {
            Visible = false;
        }
        addbefore("P&osting")
        {
            group(AdvanceLetterGrCZZ)
            {
                Caption = 'Advance Letter';
                Image = Prepayment;

                action(CreateAdvanceLetterCZZ)
                {
                    Caption = 'Create Advance Letter';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'The function create advance letter.';
                    Image = CreateDocument;
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        CreatePurchAdvLetterCZZ: Report "Create Purch. Adv. Letter CZZ";
                    begin
                        CreatePurchAdvLetterCZZ.SetPurchHeader(Rec);
                        CreatePurchAdvLetterCZZ.Run();
                    end;
                }
                action(LinkAdvanceLetterCZZ)
                {
                    Caption = 'Link Advance Letter';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'The function allows to link advance letters.';
                    Image = LinkWithExisting;
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        PurchAdvLetterManagementCZZ: Codeunit "PurchAdvLetterManagement CZZ";
                    begin
                        PurchAdvLetterManagementCZZ.LinkAdvanceLetter(
                            Rec.GetAdvLetterUsageDocTypeCZZ(), Rec."No.", Rec."Pay-to Vendor No.", Rec."Posting Date", Rec."Currency Code");
                    end;
                }
            }
        }
        addafter(Preview)
        {
            action(AdvanceVATStatisticsCZZ)
            {
                Caption = 'Advance VAT Statistics';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Shows summarized VAT Entries, include advance VAT Entries, based on posting preview.';
                Image = VATEntries;

                trigger OnAction()
                var
                    ShowPreviewHandlerCZZ: Codeunit "Show Preview Handler CZZ";
                    PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                begin
                    BindSubscription(ShowPreviewHandlerCZZ);
                    PurchPostYesNo.Preview(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if GuiAllowed() then
            CurrPage.AdvanceUsageFactBoxCZZ.Page.SetDocument(Rec);
    end;
}
