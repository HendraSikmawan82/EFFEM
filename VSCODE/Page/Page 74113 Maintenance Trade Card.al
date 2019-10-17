page 74113 "MCH Maintenance Trade Card"
{
    Caption = 'Maintenance Trade Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "MCH Maintenance Trade";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control1101214034)
                {
                    ShowCaption = false;
                    field("Code";Code)
                    {
                        ApplicationArea = Basic,Suite;
                        Style = Unfavorable;
                        StyleExpr = Blocked;
                    }
                    field(Description;Description)
                    {
                        ApplicationArea = Basic,Suite;
                        Style = Unfavorable;
                        StyleExpr = Blocked;
                    }
                    field("Description 2";"Description 2")
                    {
                        ApplicationArea = Basic,Suite;
                        Visible = false;
                    }
                    field("Item No.";"Item No.")
                    {
                        ApplicationArea = Basic,Suite;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the Item that represents the Maint. Trade as a labour time unit that is not tracked in inventory (Item Type = Service).';

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Item Description";"Item Description")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                    }
                }
                group(Control1101214028)
                {
                    ShowCaption = false;
                    group("Effective Values")
                    {
                        Caption = 'Effective Values';
                        field(EffectiveGenProdPostingGrp;FindEffectiveGenProdPostingGroup)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Gen. Prod. Posting Group';
                            Editable = false;
                            Importance = Promoted;
                            ToolTip = 'Specifies the Gen. Prod. Posting Group that will be used on purchasing.';
                        }
                        field(EffectiveVendorNo;FindEffectiveVendorNo)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Vendor No.';
                            Editable = false;
                            Importance = Promoted;
                            ToolTip = 'Specifies the Vendor No. that will be used on purchasing.';
                        }
                        field(EffectiveUnitOfMeasure;FindEffectiveUnitOfMeasure)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Unit of Measure Code';
                            Editable = false;
                            Importance = Promoted;
                            ToolTip = 'Specifies the Purch. Unit of Measure that will be used on purchasing.';
                        }
                    }
                    field("Fixed Direct Unit Cost";"Fixed Direct Unit Cost")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies a fixed default Direct Unit Cost. The item/vendor purchase price setup will be used if no value is specified.';
                    }
                    field(Blocked;Blocked)
                    {
                        ApplicationArea = Basic,Suite;
                        QuickEntry = false;
                    }
                }
            }
            group("Purchase & Posting")
            {
                Caption = 'Purchase & Posting';
                Enabled = HasItemNo;
                group("Item (Default Values)")
                {
                    Caption = 'Item (Default Values)';
                    field("Item Gen. Prod. Posting Group";"Item Gen. Prod. Posting Group")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                        Importance = Promoted;
                    }
                    field("Item Vendor No.";"Item Vendor No.")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                        Importance = Promoted;
                    }
                    field("Item Purch. Unit of Measure";"Item Purch. Unit of Measure")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                        Importance = Promoted;
                    }
                    field("Item Base Unit of Measure";"Item Base Unit of Measure")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                        Importance = Promoted;
                    }
                    field("Item Last Direct Cost";"Item Last Direct Cost")
                    {
                        ApplicationArea = Basic,Suite;
                        DrillDown = false;
                        Visible = false;
                    }
                }
                group("Trade Specific Values")
                {
                    Caption = 'Trade Specific Values';
                    field("Maint. Gen. Prod. Posting Grp.";"Maint. Gen. Prod. Posting Grp.")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies a Gen. Prod. Posting Group which will be used when Purchasing as an alternative to the default value specified on the Item card.';

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Maint. Vendor No.";"Maint. Vendor No.")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies a specific Vendor which will be used when Purchasing as an alternative to the default Vendor specified on the Item card.';

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Maint. Unit of Measure";"Maint. Unit of Measure")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies a Purch. Unit of Measure which will be used when Purchasing as an alternative to the default value specified on the Item card.';

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1101214002;Links)
            {
                ApplicationArea = Basic,Suite;
            }
            systempart(Control1101214001;Notes)
            {
                ApplicationArea = Basic,Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Co&mments")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page "MCH Maint. Comment Sheet";
                RunPageLink = "Table Name"=CONST(Trade),
                              "No."=FIELD(Code);
            }
            action(MaintTaskBudget)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Maint. Task Budget';
                Image = CostAccountingSetup;
                RunObject = Page "MCH Maint. Task Budget Lines";
                RunPageLink = "No."=FIELD(Code);
                RunPageView = SORTING(Type,"No.")
                              WHERE(Type=CONST(Trade));
            }
            action(ShowItem)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Item';
                Enabled = HasItemNo;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Item Card";
                RunPageLink = "No."=FIELD("Item No.");
                RunPageMode = View;
            }
            action(ShowPurchasePrices)
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Prices';
                Image = Price;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Set up different purchase prices for the item. An item purchase price is automatically granted on purchase lines when the specified criteria are met, such as vendor, quantity, or ending date.';

                trigger OnAction()
                begin
                    Rec.ShowPurchasePrices;
                end;
            }
            action(ShowPurchaseLineDiscounts)
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Discounts';
                Image = LineDiscount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Set up different discounts for the item. An item discount is automatically granted on purchase lines when the specified criteria are met, such as vendor, quantity, or ending date.';

                trigger OnAction()
                begin
                    Rec.ShowPurchaseDiscounts;
                end;
            }
            action(ShowPurchPricesDiscountsOverview)
            {
                ApplicationArea = Suite;
                Caption = 'Purch. Prices & Discounts';
                Image = PriceWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'View the special purchase prices and line discounts that you grant for this item when certain criteria are met, such as vendor, quantity, or ending date.';

                trigger OnAction()
                begin
                    ShowPurchPricesDiscountsOverview;
                end;
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("AM Ledger Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'AM Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page "MCH AM Ledger Entries";
                    RunPageLink = "No."=FIELD(Code);
                    RunPageView = SORTING(Type,"No.")
                                  WHERE(Type=CONST(Trade));
                }
                action("Item Ledger Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Item Ledger Entries';
                    Enabled = HasItemNo;
                    Image = ItemLedger;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No."=FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EnableControls;
    end;

    trigger OnOpenPage()
    begin
        EnableControls;
    end;

    var
        [InDataSet]
        HasItemNo: Boolean;

    local procedure EnableControls()
    begin
        HasItemNo := ("Item No." <> '');
    end;
}

