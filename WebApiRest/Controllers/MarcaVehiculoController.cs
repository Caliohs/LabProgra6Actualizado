using Entity;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WBL;

namespace WebApiRest.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MarcaVehiculoController : ControllerBase
    {

        private readonly IMarcaVehiculoService marcaVehiculo;

        public MarcaVehiculoController(IMarcaVehiculoService marcaVehiculo)
        {
            this.marcaVehiculo = marcaVehiculo;
        }


        [HttpGet("Lista")]
        public async Task<IEnumerable<MarcaVehiculoEntity>> GetLista()
        {
            try
            {
                return await marcaVehiculo.GetLista();
            }
            catch (Exception ex)
            {

                return new List<MarcaVehiculoEntity>();
            }
        }
    }
}
