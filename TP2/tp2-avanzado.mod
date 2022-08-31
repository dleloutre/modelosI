# Conjuntos
set PAISES;
set CAPACIDAD;
set MEDIOS;
set CENTROS;
set DESTINOS;
param AYUDA_DISPONIBLE{i in PAISES};
param CAPACIDAD_CENTROS{j in CENTROS, k in MEDIOS};
param CAPACIDAD_DESTINOS{d in DESTINOS, k in MEDIOS};
param COSTO_PAISES_SAN_PABLO{j in PAISES, k in MEDIOS}; 
param COSTO_PAISES_PANAMA{j in PAISES, k in MEDIOS};
param COSTO_PAISES_BOGOTA{j in PAISES, k in MEDIOS};
param COSTO_PAISES_NUEVA_YORK{j in PAISES, k in MEDIOS};
param COSTO_PAISES_MIAMI{j in PAISES, k in MEDIOS};
param COSTO_PAISES_AMSTERDAM{j in PAISES, k in MEDIOS};
param COSTO_PAISES_LONDRES{j in PAISES, k in MEDIOS};
param COSTO_PAISES_ROMA{j in PAISES, k in MEDIOS};
param COSTO_PAISES_ESTAMBUL{j in PAISES, k in MEDIOS};
param COSTO_PAISES_HAIFA{j in PAISES, k in MEDIOS};
param COSTO_PAISES_TOKIO{j in PAISES, k in MEDIOS};
param COSTO_PAISES_TAIPEI{j in PAISES, k in MEDIOS};
param COSTO_CENTROS_SAN_PABLO{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_PANAMA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_BOGOTA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_NUEVA_YORK{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_MIAMI{j in CENTROS, k in MEDIOS}; 
param COSTO_CENTROS_AMSTERDAM{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_LONDRES{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_ROMA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_ESTAMBUL{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_HAIFA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_TOKIO{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_TAIPEI{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_VARSOVIA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_BRATISLAVA{j in CENTROS, k in MEDIOS};
param COSTO_CENTROS_BUCAREST{j in CENTROS, k in MEDIOS};
param AYUDA := 31000000;
#Variables:
var O{i in PAISES} >= 0;
var O_T{i in PAISES, j in CENTROS} >= 0;
var O_T_V{i in PAISES, j in CENTROS, k in MEDIOS} >= 0;
var T{j in CENTROS} >= 0;
var T_T{j in CENTROS, h in CENTROS} >= 0;
var T_D{j in CENTROS, d in DESTINOS} >= 0;
var T_T_V{j in CENTROS, h in CENTROS, k in MEDIOS} >= 0;
var T_D_V{j in CENTROS, d in DESTINOS, k in MEDIOS} >= 0;
var D{d in DESTINOS} >= 0;
var D_V{d in DESTINOS, k in MEDIOS} >= 0;
var COSTO_TOTAL >= 0;

var COSTO_PAISES_A_SAN_PABLO >= 0;
var COSTO_PAISES_A_PANAMA >= 0;
var COSTO_PAISES_A_BOGOTA >= 0; 
var COSTO_PAISES_A_NUEVA_YORK >= 0; 
var COSTO_PAISES_A_MIAMI >= 0;
var COSTO_PAISES_A_AMSTERDAM >= 0; 
var COSTO_PAISES_A_LONDRES >= 0;
var COSTO_PAISES_A_ROMA >= 0;
var COSTO_PAISES_A_ESTAMBUL >= 0;
var COSTO_PAISES_A_HAIFA >= 0; 
var COSTO_PAISES_A_TOKIO >= 0;
var COSTO_PAISES_A_TAIPEI >= 0;

var COSTO_CENTROS_A_SAN_PABLO >= 0;
var COSTO_CENTROS_A_PANAMA >= 0; 
var COSTO_CENTROS_A_BOGOTA >= 0;
var COSTO_CENTROS_A_NUEVA_YORK >= 0;
var COSTO_CENTROS_A_MIAMI >= 0; 
var COSTO_CENTROS_A_AMSTERDAM >= 0;
var COSTO_CENTROS_A_LONDRES >= 0;
var COSTO_CENTROS_A_ROMA >= 0; 
var COSTO_CENTROS_A_ESTAMBUL >= 0; 
var COSTO_CENTROS_A_HAIFA >= 0;
var COSTO_CENTROS_A_TOKIO >= 0; 
var COSTO_CENTROS_A_TAIPEI >= 0;
var COSTO_CENTROS_A_VARSOVIA >= 0; 
var COSTO_CENTROS_A_BRATISLAVA >= 0; 
var COSTO_CENTROS_A_BUCAREST >= 0; 
#Funcional:
maximize z: sum{i in PAISES} O[i];
#Restricciones
#ORIGENES - PAÍSES
#Cantidad de ayuda humanitaria que envia cada país
s.t. AYUDA_PAISES{i in PAISES}: sum{j in CENTROS} O_T[i,j] = O[i];
#Cantidad de ayuda humanitaria que envia el país i-ésimo al centro regional j-esimo
s.t. AYUDA_PAISES_CENTROS{i in PAISES, j in CENTROS}: O_T[i, j] = sum{k in MEDIOS} O_T_V[i,j,k];
#Cantidad de ayuda humanitaria que envia el pais i-ésimo esta limitada por el disponible de ayuda que puede brindar
s.t. AYUDA_PAISES_DISP{i in PAISES}: O[i] <= AYUDA_DISPONIBLE[i];

#CENTROS REGIONALES
#Cantidad de ayuda humanitaria que recibe el centro regional j-ésimo por la via k-ésima tanto de países como de otros centros está limitado por su capacidad máxima asociada por dicha vía
s.t. CAPACIDAD_CENTROS_MEDIOS{j in CENTROS, k in MEDIOS}: sum{i in PAISES}O_T_V[i,j,k] + sum{h in CENTROS: h<>j} T_T_V[j,h,k] <= CAPACIDAD_CENTROS[j,k];
#Cantidad de ayuda humanitaria que se envía desde cada centro regional j-ésimo
s.t. AYUDA_CENTROS_ENVIA{j in CENTROS}: T[j] = sum{h in CENTROS: h<>j} T_T[j, h] + sum{d in DESTINOS} T_D[j, d];
#Cantidad de ayuda humanitaria que se envía desde el centro j-ésimo a otros centros
s.t. AYUDA_CENTROS_CENTROS{j in CENTROS, h in CENTROS: h<>j}: T_T[j, h] = sum{k in MEDIOS} T_T_V[j,h,k];
#Cantidad de ayuda humanitaria que se envía desde el centro j-ésimo a destinos finales
s.t. AYUDA_CENTROS_DESTINOS{j in CENTROS, d in DESTINOS}: T_D[j, d] = sum{k in MEDIOS} T_D_V[j,d,k];
#Cantidad de ayuda humanitaria que recibe el centro regional j-ésimo es igual a la cantidad de ayuda humanitaria que el centro j-ésimo envía tanto a otros centros regionales como a destinos finales
s.t. AYUDA_CENTROS_RECIBE{j in CENTROS}: T[j] = sum{i in PAISES, k in MEDIOS}O_T_V[i,j,k] + sum{k in MEDIOS,h in CENTROS: h<>j} T_T_V[j,h,k];

#DESTINOS
#Cantidad de ayuda humanitaria que recibe el destino d-ésimo
s.t. AYUDA_DESTINOS{d in DESTINOS, k in MEDIOS}: D_V[d,k] = sum{j in CENTROS}T_D_V[j,d,k];
#Cantidad de ayuda humanitaria que recibe el destino d-ésimo por la via k-ésima
s.t. CAPACIDAD_DESTINOS_MEDIOS{d in DESTINOS, k in MEDIOS}: D_V[d,k] <= CAPACIDAD_DESTINOS[d,k];
#Cantidad de ayuda humanitaria recibida total por cada destino
s.t. CANTIDAD_AYUDA_DESTINOS{d in DESTINOS}: D[d] = sum{k in MEDIOS}D_V[d,k];

#COSTOS
#Costos paises a centros
s.t. COSTOS_PAISES_SAN_PABLO: COSTO_PAISES_A_SAN_PABLO = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_SAN_PABLO[i,k] *  O_T_V[i,'SAN_PABLO',k];
s.t. COSTOS_PAISES_PANAMA: COSTO_PAISES_A_PANAMA = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_PANAMA[i,k] * O_T_V[i,'PANAMA',k];
s.t. COSTOS_PAISES_BOGOTA: COSTO_PAISES_A_BOGOTA = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_BOGOTA[i,k] * O_T_V[i,'BOGOTA',k];
s.t. COSTOS_PAISES_NUEVA_YORK: COSTO_PAISES_A_NUEVA_YORK = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_NUEVA_YORK[i,k] * O_T_V[i,'NUEVA_YORK',k];
s.t. COSTOS_PAISES_MIAMI: COSTO_PAISES_A_MIAMI = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_MIAMI[i,k] * O_T_V[i,'MIAMI',k];
s.t. COSTOS_PAISES_AMSTERDAM: COSTO_PAISES_A_AMSTERDAM = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_AMSTERDAM[i,k] * O_T_V[i,'AMSTERDAM',k];
s.t. COSTOS_PAISES_LONDRES: COSTO_PAISES_A_LONDRES = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_LONDRES[i,k] * O_T_V[i,'LONDRES',k];
s.t. COSTOS_PAISES_ROMA: COSTO_PAISES_A_ROMA = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_ROMA[i,k] * O_T_V[i,'ROMA',k];
s.t. COSTOS_PAISES_ESTAMBUL: COSTO_PAISES_A_ESTAMBUL = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_ESTAMBUL[i,k] * O_T_V[i,'ESTAMBUL',k];
s.t. COSTOS_PAISES_HAIFA: COSTO_PAISES_A_HAIFA = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_HAIFA[i,k] * O_T_V[i,'HAIFA',k];
s.t. COSTOS_PAISES_TOKIO: COSTO_PAISES_A_TOKIO = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_TOKIO[i,k] * O_T_V[i,'TOKIO',k];
s.t. COSTOS_PAISES_TAIPEI: COSTO_PAISES_A_TAIPEI = sum{i in PAISES, k in MEDIOS}COSTO_PAISES_TAIPEI[i,k] * O_T_V[i,'TAIPEI',k];
#Costos centros a centros/destinos
s.t. COSTOS_CENTROS_SAN_PABLO: COSTO_CENTROS_A_SAN_PABLO = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_SAN_PABLO[j,k] * T_T_V[j,'SAN_PABLO',k];
s.t. COSTOS_CENTROS_PANAMA: COSTO_CENTROS_A_PANAMA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_PANAMA[j,k] * T_T_V[j,'PANAMA',k];
s.t. COSTOS_CENTROS_BOGOTA: COSTO_CENTROS_A_BOGOTA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_BOGOTA[j,k] * T_T_V[j,'BOGOTA',k];
s.t. COSTOS_CENTROS_NUEVA_YORK: COSTO_CENTROS_A_NUEVA_YORK = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_NUEVA_YORK[j,k] * T_T_V[j,'NUEVA_YORK',k];
s.t. COSTOS_CENTROS_MIAMI: COSTO_CENTROS_A_MIAMI = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_MIAMI[j,k] * T_T_V[j,'MIAMI',k];
s.t. COSTOS_CENTROS_AMSTERDAM: COSTO_CENTROS_A_AMSTERDAM = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_AMSTERDAM[j,k] * T_T_V[j,'AMSTERDAM',k];
s.t. COSTOS_CENTROS_LONDRES: COSTO_CENTROS_A_LONDRES = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_LONDRES[j,k] * T_T_V[j,'LONDRES',k];
s.t. COSTOS_CENTROS_ROMA: COSTO_CENTROS_A_ROMA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_ROMA[j,k] * T_T_V[j,'ROMA',k];
s.t. COSTOS_CENTROS_ESTAMBUL: COSTO_CENTROS_A_ESTAMBUL = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_ESTAMBUL[j,k] * T_T_V[j,'ESTAMBUL',k];
s.t. COSTOS_CENTROS_HAIFA: COSTO_CENTROS_A_HAIFA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_HAIFA[j,k] * T_T_V[j,'HAIFA',k];
s.t. COSTOS_CENTROS_TOKIO: COSTO_CENTROS_A_TOKIO = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_TOKIO[j,k] * T_T_V[j,'TOKIO',k];
s.t. COSTOS_CENTROS_TAIPEI: COSTO_CENTROS_A_TAIPEI = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_TAIPEI[j,k] * T_T_V[j,'TAIPEI',k];
s.t. COSTOS_CENTROS_VARSOVIA: COSTO_CENTROS_A_VARSOVIA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_VARSOVIA[j,k] * T_D_V[j,'VARSOVIA',k];
s.t. COSTOS_CENTROS_BRATISLAVA: COSTO_CENTROS_A_BRATISLAVA = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_BRATISLAVA[j,k] * T_D_V[j,'BRATISLAVA',k];
s.t. COSTOS_CENTROS_BUCAREST: COSTO_CENTROS_A_BUCAREST = sum{j in CENTROS, k in MEDIOS}COSTO_CENTROS_BUCAREST[j,k] * T_D_V[j,'BUCAREST',k];
#Costo de traslado y de manipulación total
s.t. COSTO: COSTO_TOTAL =  COSTO_PAISES_A_SAN_PABLO + COSTO_PAISES_A_PANAMA + COSTO_PAISES_A_BOGOTA +  COSTO_PAISES_A_NUEVA_YORK +  COSTO_PAISES_A_MIAMI + COSTO_PAISES_A_AMSTERDAM +  COSTO_PAISES_A_LONDRES + COSTO_PAISES_A_ROMA + COSTO_PAISES_A_ESTAMBUL + COSTO_PAISES_A_HAIFA +  COSTO_PAISES_A_TOKIO + COSTO_PAISES_A_TAIPEI + COSTO_CENTROS_A_SAN_PABLO + COSTO_CENTROS_A_PANAMA +  COSTO_CENTROS_A_BOGOTA + COSTO_CENTROS_A_NUEVA_YORK + COSTO_CENTROS_A_MIAMI +  COSTO_CENTROS_A_AMSTERDAM + COSTO_CENTROS_A_LONDRES + COSTO_CENTROS_A_ROMA +  COSTO_CENTROS_A_ESTAMBUL +  COSTO_CENTROS_A_HAIFA + COSTO_CENTROS_A_TOKIO +  COSTO_CENTROS_A_TAIPEI + COSTO_CENTROS_A_VARSOVIA +  COSTO_CENTROS_A_BRATISLAVA +  COSTO_CENTROS_A_BUCAREST;
#Costo total de los traslados esta limitado por la financiación
s.t. COSTO_LIMITADO: COSTO_TOTAL <= AYUDA;
end;
