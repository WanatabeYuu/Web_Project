namespace Web_bh.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int Id { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(100)]
        public string Detail { get; set; }

        public int? PrinceOld { get; set; }

        public int? PriceNew { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Date { get; set; }

        public bool? Status { get; set; }

        public int? Group_Product { get; set; }

        [StringLength(100)]
        public string Image { get; set; }

        public bool? Hotdeal { get; set; }

        public int? Sold { get; set; }

        public virtual GroupProduct GroupProduct { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
