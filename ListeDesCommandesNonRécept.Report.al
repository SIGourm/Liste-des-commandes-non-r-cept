report 50112 "Liste des commandes non récept"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    // Use an RDL layout.
    DefaultLayout = RDLC;

    // Specify the name of the file that the report will use for the layout.
    RDLCLayout = 'Liste des commandes non récept.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {

            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";


            column(No_; "No.")
            {

            }
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "No." = field("No.");

                DataItemLinkReference = "Purchase Header";


                column(Document_No_; "Document No.")
                {

                }
                column(Expected_Receipt_Date; "Expected Receipt Date")
                {

                }
                //column(No_; "No.")
                //{

                //}
                column(Description; Description)
                {

                }
                column(Amount; Amount)
                {

                }
                column(Quantity_Received; "Quantity Received")
                {

                }
                column(Order_Date; "Order Date")
                {

                }

                trigger OnAfterGetRecord()
                begin

                    QteNonRecep := "Purchase Line".Quantity - "Purchase Line"."Quantity Received";
                    IF QteNonRecep = 0 THEN CurrReport.SKIP;
                end;

            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    //field(Name; SourceExpression)
                    //{
                    //    ApplicationArea = All;

                    //}
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    /*rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }*/

    var
        myInt: Integer;
        Lvendor: Record "Vendor";
        LigneReception: Record "Purch. Rcpt. Line";
        SOCIETE: Record "Company Information";
        listreceipt: Text[1024];
        filter: Text[250];
        FilterCommandeNo: Code[20];
        MTNonRecept: Decimal;
        QteNonRecep: Decimal;

}