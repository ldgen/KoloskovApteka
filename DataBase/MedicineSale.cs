//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace KoloskovApteka.DataBase
{
    using System;
    using System.Collections.Generic;
    
    public partial class MedicineSale
    {
        public int SaleID { get; set; }
        public System.DateTime Date { get; set; }
        public int MedicineID { get; set; }
        public int Quantity { get; set; }
        public int PrescriptionID { get; set; }
        public int SellerID { get; set; }
    
        public virtual Medicine Medicine { get; set; }
        public virtual MedicinePrescription MedicinePrescription { get; set; }
        public virtual Seller Seller { get; set; }
    }
}
