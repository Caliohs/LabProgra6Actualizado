using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;

namespace WebApplication.Pages.Vehiculo
{
    public class EditModel : PageModel
    {
        private readonly ServiceApi service;

        public EditModel(ServiceApi service)
        {
            this.service = service;
        }


        [BindProperty(SupportsGet = true)]
        public int? id { get; set; }

        [BindProperty]
        [FromBody]
        public VehiculoEntity Entity { get; set; } = new VehiculoEntity();
        public IEnumerable<MarcaVehiculoEntity> MarcaVehiculoLista { get; set; } = new List<MarcaVehiculoEntity>();

        public async Task<IActionResult> OnGet()
        {
            try
            {
                if (id.HasValue)
                {
                    Entity = await service.VehiculosGetById(id.Value);
                }
                MarcaVehiculoLista = await service.MarcaVehiculoGetLista();

                return Page();
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }

        }


        //public async Task<IActionResult> OnPost()
        //{
        //    try
        //    {

        //        var result = new DBEntity();
        //        if (Entity.VehiculoId.HasValue)
        //        {
        //            //Actualizar
        //            result = await vehiculoService.Update(Entity);


        //        }
        //        else
        //        {
        //            //Nuevo
        //            result = await vehiculoService.Create(Entity);


        //        }

        //        return new JsonResult(result);


        //    }
        //    catch (Exception ex)
        //    {

        //        return new JsonResult(new DBEntity { CodeError = ex.HResult, MsgError = ex.Message });
        //    }

        //}
    }
}
