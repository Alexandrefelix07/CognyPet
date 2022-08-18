/* Controlador de componentes */
({
 downloadDocument : function (componente, evento, auxiliar){

  var sendDataProc = component.get( "v.sendData" );
  var dataToSend = {
    "label" : "Isso é teste" 
  }; //esses são os dados que você deseja enviar para geração de PDF

  //invoca o método js da página vf 
  sendDataProc(dataToSend, function (){
               //trata o retorno de chamada
  });
 }
})