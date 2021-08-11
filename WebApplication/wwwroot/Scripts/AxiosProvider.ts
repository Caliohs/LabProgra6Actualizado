
namespace App.AxiosProvider   {

    //export const GuardarEmpleado = () => axios.get<Entity.DBEntity>("aplicacion").then(({data})=>data );

    export const AgenciaEliminar = (id) => axios.delete<DBEntity>("Agencia/Grid?handler=Eliminar&id=" + id).then(({ data }) => data);

    export const AgenciaGuardar = (entity) => axios.post<DBEntity>("Agencia/Edit",entity).then(({ data }) => data);

    export const AgenciaChangeProvincia = (entity) => axios.post<any[]>("Agencia/Edit?handler=ChangeProvincia",entity).then(({ data }) => data);

    export const AgenciaChangeCanton = (entity) => axios.post<any[]>("Agencia/Edit?handler=ChangeCanton", entity).then(({ data }) => data);

    export const MarcaVehiculoEliminar = (id) => axios.delete<DBEntity>("MarcaVehiculo/Grid?handler=Eliminar&id=" + id).then(({ data }) => data);

    export const MarcaVehiculoGuardar = (entity) => axios.post<DBEntity>("MarcaVehiculo/Edit", entity).then(({ data }) => data);

    //export const VehiculoEliminar = (id) => axios.delete<DBEntity>("Vehiculo/Grid?handler=Eliminar&id=" + id).then(({ data }) => data);

    //export const VehiculoGuardar = (entity) => axios.post<DBEntity>("Vehiculo/Edit", entity).then(({ data }) => data);

    export const ClientesEliminar = (id) => ServiceApi.delete<DBEntity>("api/Clientes/" + id).then(({ data }) => data);

    export const ClientesGuardar = (entity) => ServiceApi.post<DBEntity>("api/Clientes", entity).then(({ data }) => data);

    export const ClientesActualizar = (entity) => ServiceApi.put<DBEntity>("api/Clientes", entity).then(({ data }) => data);

    export const VehiculosEliminar = (id) => ServiceApi.delete<DBEntity>("api/Vehiculos/" + id).then(({ data }) => data);

    export const VehiculosGuardar = (entity) => ServiceApi.post<DBEntity>("api/Vehiculos", entity).then(({ data }) => data);

    export const VehiculosActualizar = (entity) => ServiceApi.put<DBEntity>("api/Vehiculos", entity).then(({ data }) => data);
}




