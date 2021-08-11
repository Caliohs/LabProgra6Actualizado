using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace WebApplication
{
    public class ServiceApi
    {
        private readonly HttpClient client;

        public ServiceApi(HttpClient client )
        {
            this.client = client;
        }

        #region Clientes
        public async Task<IEnumerable<ClientesEntity>> ClientesGet()
        {
            var result = await client.ServicioGetAsync<IEnumerable<ClientesEntity>>("api/Clientes");

            return result;
        
        }

        public async Task<ClientesEntity> ClientesGetById(int id)
        {
            var result = await client.ServicioGetAsync<ClientesEntity>("api/Clientes/" + id);

            if (result.CodeError is not 0) throw new Exception(result.MsgError);

            return result;

        }

        public async Task<IEnumerable<AgenciaEntity>> AgenciaGetLista()
        {
            var result = await client.ServicioGetAsync<IEnumerable<AgenciaEntity>>("api/Agencia/Lista");

            return result;

        }

        #endregion

        #region Vehiculos
        public async Task<IEnumerable<VehiculoEntity>> VehiculosGet()
        {
            var result = await client.ServicioGetAsync<IEnumerable<VehiculoEntity>>("api/Vehiculos");

            return result;

        }

        public async Task<VehiculoEntity> VehiculosGetById(int id)
        {
            var result = await client.ServicioGetAsync<VehiculoEntity>("api/Vehiculos/" + id);

            if (result.CodeError is not 0) throw new Exception(result.MsgError);

            return result;

        }

        public async Task<IEnumerable<MarcaVehiculoEntity>> MarcaVehiculoGetLista()
        {
            var result = await client.ServicioGetAsync<IEnumerable<MarcaVehiculoEntity>>("api/MarcaVehiculo/Lista");

            return result;

        }

        #endregion
    }
}
