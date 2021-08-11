"use strict";
var VehiculoEdit;
(function (VehiculoEdit) {
    var Entity = $("#AppEdit").data("entity");
    var Formulario = new Vue({
        data: {
            Formulario: "#FormEdit",
            Entity: Entity,
        },
        methods: {
            VehiculoServicio: function (entity) {
                console.log(entity);
                if (entity.VehiculoId == null) {
                    return App.AxiosProvider.VehiculosGuardar(entity);
                }
                else {
                    return App.AxiosProvider.VehiculosActualizar(entity);
                }
            },
            Save: function () {
                if (BValidateData(this.Formulario)) {
                    Loading.fire("Guardando");
                    this.VehiculoServicio(this.Entity).then(function (data) {
                        Loading.close();
                        if (data.CodeError == 0) {
                            Toast.fire({ title: "Se guardó satisfactoriamente", icon: "success" })
                                .then(function () { return window.location.href = "Vehiculo/Grid"; });
                        }
                        else {
                            Toast.fire({ title: data.MsgError, icon: "error" });
                        }
                    });
                }
                else {
                    Toast.fire({ title: "Por favor complete los campos requeridos", icon: "error" });
                }
            }
        },
        mounted: function () {
            CreateValidator(this.Formulario);
        }
    });
    Formulario.$mount("#AppEdit");
})(VehiculoEdit || (VehiculoEdit = {}));
//# sourceMappingURL=Edit.js.map