"use strict";
var VehiculoGrid;
(function (VehiculoGrid) {
    function OnClickEliminar(id) {
        ComfirmAlert("Desea eliminar el registro?", "Eliminar", "warning", "#3085d6", "#d33")
            .then(function (result) {
            if (result.isConfirmed) {
                Loading.fire("Borrando...");
                App.AxiosProvider.VehiculosEliminar(id).then(function (data) {
                    Loading.close();
                    if (data.CodeError == 0) {
                        Toast.fire({ title: "Se eliminĂ³ correctamente", icon: "success" }).then(function () { return window.location.href = "Vehiculo/Grid"; });
                    }
                    else {
                        Toast.fire({ title: data.MsgError, icon: "error" });
                    }
                });
            }
        });
    }
    VehiculoGrid.OnClickEliminar = OnClickEliminar;
    $("#GridView").DataTable();
})(VehiculoGrid || (VehiculoGrid = {}));
//# sourceMappingURL=Grid.js.map