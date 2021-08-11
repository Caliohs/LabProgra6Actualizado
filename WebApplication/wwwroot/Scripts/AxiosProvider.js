"use strict";
var App;
(function (App) {
    var AxiosProvider;
    (function (AxiosProvider) {
        //export const GuardarEmpleado = () => axios.get<Entity.DBEntity>("aplicacion").then(({data})=>data );
        AxiosProvider.AgenciaEliminar = function (id) { return axios.delete("Agencia/Grid?handler=Eliminar&id=" + id).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.AgenciaGuardar = function (entity) { return axios.post("Agencia/Edit", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.AgenciaChangeProvincia = function (entity) { return axios.post("Agencia/Edit?handler=ChangeProvincia", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.AgenciaChangeCanton = function (entity) { return axios.post("Agencia/Edit?handler=ChangeCanton", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.MarcaVehiculoEliminar = function (id) { return axios.delete("MarcaVehiculo/Grid?handler=Eliminar&id=" + id).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.MarcaVehiculoGuardar = function (entity) { return axios.post("MarcaVehiculo/Edit", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        //export const VehiculoEliminar = (id) => axios.delete<DBEntity>("Vehiculo/Grid?handler=Eliminar&id=" + id).then(({ data }) => data);
        //export const VehiculoGuardar = (entity) => axios.post<DBEntity>("Vehiculo/Edit", entity).then(({ data }) => data);
        AxiosProvider.ClientesEliminar = function (id) { return ServiceApi.delete("api/Clientes/" + id).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.ClientesGuardar = function (entity) { return ServiceApi.post("api/Clientes", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.ClientesActualizar = function (entity) { return ServiceApi.put("api/Clientes", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.VehiculosEliminar = function (id) { return ServiceApi.delete("api/Vehiculos/" + id).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.VehiculosGuardar = function (entity) { return ServiceApi.post("api/Vehiculos", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
        AxiosProvider.VehiculosActualizar = function (entity) { return ServiceApi.put("api/Vehiculos", entity).then(function (_a) {
            var data = _a.data;
            return data;
        }); };
    })(AxiosProvider = App.AxiosProvider || (App.AxiosProvider = {}));
})(App || (App = {}));
//# sourceMappingURL=AxiosProvider.js.map