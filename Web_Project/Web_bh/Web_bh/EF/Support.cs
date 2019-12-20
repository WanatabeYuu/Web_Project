namespace Web_bh.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Support")]
    public partial class Support
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Phone { get; set; }

        [StringLength(50)]
        public string Name { get; set; }

        [Column("Support")]
        public string Support1 { get; set; }
    }
}
