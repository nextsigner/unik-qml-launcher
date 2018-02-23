import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import uk 1.0
ApplicationWindow {
    id: app
    visible: true
    width: 100
    height: 100
    x:0
    y:0
    title: qsTr("launcher")
    property int fs: app.anchoBoton*0.08
    property color c1: "#1fbc05"
    property color c2: "#4fec35"
    property color c3: "white"
    property color c4: "black"
    property color c5: "#333333"

    property int anchoBoton: 80
    property int estado: 1
    property bool onTop: false
    //flags: Qt.ToolTip | Qt.WindowStaysOnTopHint
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"
    onOnTopChanged: {
        if(onTop){
            app.flags = Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
        }else{
            app.flags = Qt.Window | Qt.FramelessWindowHint
        }
    }
    UK{id:uk}
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Rectangle{
        id:x
        color: app.c5
        width: app.estado===1?app.anchoBoton:anchoBoton*0.15
        height: app.estado===2?app.anchoBoton:anchoBoton*0.15
        z: gridIconos.z+1
        border.width: 2
        border.color: app.c2
        radius: app.estado === 1 ? width*0.2 : height*0.2

        MouseArea{
            id: max
            property variant clickPos: "1,1"
            property bool presionado: false
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                car.txt = "Arrastrar"
                car.visible = true
            }
            onExited: {
                car.txt = ""
                car.visible = false
            }
            onDoubleClicked: {
                //config.visible = !config.visible
            }
            onReleased: {
                presionado = false
                saveConfig()
            }
            onPressed: {
                presionado = true
                clickPos  = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                if(presionado){
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    app.x += delta.x;
                    app.y += delta.y;
                }
            }
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    console.log(wheel.angleDelta.y / 120)
                    if(app.anchoBoton>=100&&app.anchoBoton<=500){
                        app.anchoBoton += wheel.angleDelta.y / 120
                        redim()
                    }
                    if(app.anchoBoton<100){
                        app.anchoBoton=100
                    }
                    if(app.anchoBoton>500){
                        app.anchoBoton=500
                    }

                }
            }

        }
        Grid{
            //anchors.fill: parent
            //width: rows===1 ? app.anchoBoton*0.15 : parent.width
            width: app.estado === 1 ? (app.anchoBoton*0.15)*4 : app.anchoBoton*0.15
            height: app.estado === 1 ? app.anchoBoton*0.15 : (app.anchoBoton*0.15)*4

            //height: rows!==1 ? parent.height : app.anchoBoton*0.15
            anchors.centerIn: parent
            rows: app.estado === 1 ? 1 : 4
            columns: app.estado === 1 ? 4 : 1
            //rotation: app.estado === 1 ? 0 : 90
            Rectangle{
                id:xBotRot
                color: app.c1
                width: app.anchoBoton*0.15
                height: width
                radius: width*0.5

                Text{
                    font.family: "FontAwesome"
                    font.pixelSize: parent.width*0.6
                    text: "\uf021"
                    anchors.centerIn: parent
                    color: "white"
                    rotation: gridIconos.orientation === ListView.Horizontal ? 90 : 0

                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        car.txt = app.estado === 1 ? "Ver en Horizontal" : "Ver en Vertical"
                        car.visible = true
                    }
                    onExited: {
                        car.txt = ""
                        car.visible = false
                    }
                    onClicked: {
                        posicionar()
                        if(config.visible){
                            app.width = config.width+app.anchoBoton
                            app.height = config.height
                        }
                    }

                }
            }
            Rectangle{
                id:xBotPos
                color: app.c1
                width: app.anchoBoton*0.15
                height: width
                radius: width*0.5
                Text{
                    font.family: "FontAwesome"
                    font.pixelSize: parent.width*0.6
                    text: "\uf08d"
                    anchors.centerIn: parent
                    color: "white"
                    rotation: app.onTop ? 0 : 45
                }
                Rectangle{
                    visible: app.onTop
                    width: parent.width/4
                    height: parent.height/4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: app.c1
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        car.txt = "Siempre encima"
                        car.visible = true
                    }
                    onExited: {
                        car.txt = ""
                        car.visible = false
                    }
                    onClicked: {
                        app.onTop = !app.onTop
                        saveConfig()
                    }
                }
            }
            Rectangle{
                id:xBotConfig
                color: app.c1
                width: app.anchoBoton*0.15
                height: width
                radius: width*0.5
                Text{
                    font.family: "FontAwesome"
                    font.pixelSize: parent.width*0.6
                    text: "\uf085"
                    anchors.centerIn: parent
                    color: "white"
                    //rotation: app.onTop ? 0 : 45
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        car.txt = "Configurar"
                        car.visible = true
                    }
                    onExited: {
                        car.txt = ""
                        car.visible = false
                    }
                    onClicked: {
                        config.visible = !config.visible
                    }
                }
            }
            Rectangle{
                id:xBotCerrar
                color: app.c1
                width: app.anchoBoton*0.15
                height: width
                radius: width*0.5
                Text{
                    font.family: "FontAwesome"
                    font.pixelSize: parent.width*0.6
                    text: "\uf067"
                    anchors.centerIn: parent
                    color: "white"
                    rotation: 45
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        car.txt = "Cerrar"
                        car.visible = true
                    }
                    onExited: {
                        car.txt = ""
                        car.visible = false
                    }
                    onClicked: {
                        Qt.quit()
                    }
                }
            }

        }

    }
    //        //anchors.fill: parent
    ListView{
        id:gridIconos
        width: app.width
        height: app.height
        x: app.estado === 1 ? 0 : app.anchoBoton*0.15
        y: app.estado === 1 ? app.anchoBoton*0.15 : 0
        model: lm
        delegate: icono
        orientation: app.width>app.anchoBoton*2 ?  ListView.Horizontal : ListView.Vertical
        spacing: 0
        boundsBehavior: ListView.StopAtBounds
    }
    ListModel{
        id: lm
        function add(n, u, i){
            return{
                nombre: n,
                ubic: u,
                itemNom:i
            }
        }
    }

    Component{
        id:icono
        Item{
            id: itemIcono
            width: anchoBoton
            height: width
            Rectangle{
                width: parent.width*0.9
                height: width
                anchors.centerIn: parent
                color: 'transparent'
                border.width: 1
                border.color: app.c1
                radius: width*0.2
                clip: true
                Image {
                    id: imgIcon
                    source: ubic
                    width: parent.width*0.8
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }

                Text {
                    id: nameApp
                    text: nombre
                    font.pixelSize: parent.width*0.1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.9
                    wrapMode: Text.WrapAnywhere
                    color: app.c1
                    horizontalAlignment: Text.AlignHCenter
                    Rectangle{
                        anchors.fill: parent
                        z:parent.z-1
                        color: app.c5
                        border.width: 2
                        border.color: app.c2
                        radius: height*0.2
                    }
                }
                MouseArea{
                    id: ma
                    property bool presionado: false
                    anchors.fill: parent
                    onClicked:{
                        ma.presionado = false

                        var cl
                        if(Qt.platform.os==='windows'){
                            cl= '"'+uk.getPath(1)+'/unik.exe" -appName '+nombre
                        }else if(Qt.platform.os==='linux'){
                            cl= '"'+uk.getPath(1)+'/unik.AppImage" -appName '+nombre
                        }else{
                            cl= '"'+uk.getPath(1)+'/unik" -appName '+nombre
                        }
                        console.log(cl)
                        uk.run(cl)
                    }
                    onPressed: {
                        ma.presionado = true
                        tl.start()
                    }
                    onReleased: {
                        ma.presionado = false
                    }
                    Timer{
                        id: tl
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: {
                            if(ma.presionado){
                                fileDialogIcon.nindex = index
                                fileDialogIcon.visible =  true

                            }
                            ma.presionado = false
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id:car
        visible: false
        width: app.anchoBoton
        height: app.fs*1.4
        radius: app.fs*0.25
        z:1000
        y: app.estado === 1 ? app.fs*2 : 0
        property string txt
        Text {
            text: car.txt
            font.pixelSize: app.fs
            anchors.centerIn: parent
        }
    }
    Rectangle{
        id:car2
        width: app.anchoBoton
        height: app.fs*1.4
        radius: app.fs*0.25
        z:1000
        y: car.y+height
        visible: car.txt === 'Arrastrar'
        Text {
            text: "Ctrl+MouseWheel Zoom"
            font.pixelSize: app.fs*0.8
            anchors.centerIn: parent
        }
    }

    Rectangle{
        id:config
        width: app.anchoBoton*3
        height: app.anchoBoton*3
        color: app.c5
        border.width: 2
        border.color: app.c2
        radius: app.fs*0.5
        //clip: true
        anchors.left: x.right
        property int fs: 16
        visible: false
        onVisibleChanged: {
            if(config.visible){
                app.width = config.width+app.anchoBoton
                app.height = config.height
            }
        }
        Column{
            width: parent.width
            height: parent.height
            spacing: 0
            Rectangle{
                id: titEditConf
                width: parent.width
                height: app.fs*1.4
                color: app.c1
                Text {
                    id: titEditor
                    text: "config-unik-launcher editor"
                    font.pixelSize: app.fs
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        //car3.txt = "Arrastrar"
                        car3.visible = true
                    }
                    onExited: {
                        //car3.txt = ""
                        car3.visible = false
                    }
                    onWheel: {
                        if (wheel.modifiers & Qt.ControlModifier) {
                            console.log(wheel.angleDelta.y / 120)
                            if(config.fs>=8&&config.fs<=60){
                                config.fs += wheel.angleDelta.y / 120
                                tsave.restart()
                            }
                            if(config.fs===7){
                                config.fs++
                            }
                            if(config.fs===60){
                                config.fs--
                            }
                        }
                    }

                }
                Rectangle{
                    id:car3
                    visible: false
                    width: app.anchoBoton*2
                    height: app.fs*1.4
                    radius: app.fs*0.25
                    z:1000
                    //y: app.estado === 1 ? app.fs*2 : 0
                    //property string txt
                    Text {
                        text: "Ctrl+MouseWheel Config Zoom"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
            }
            Rectangle{
                id:xTa
                width: parent.width-app.fs
                height: config.height-filaBotones.height-titEditConf.height-20
                anchors.horizontalCenter: parent.horizontalCenter
                color: app.c5
                TextArea{
                    id: ta
                    width: parent.width-app.fs*2
                    height: parent.width
                    x: 0-app.fs*0.5

                    font.pixelSize: config.fs
                    color: app.c2
                    wrapMode: Text.WrapAnywhere
                    anchors.horizontalCenter: parent.horizontalCenter

                }
            }
            Row{
                id: filaBotones
                width:  parent.width-app.fs
                height: app.fs*1.4
                spacing: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                Button{
                    width: app.fs*6
                    height: app.fs*1.4
                    font.pixelSize: app.fs
                    text: "Cancelar"
                }
                Button{
                    width: app.fs*6
                    height: app.fs*1.4
                    font.pixelSize: app.fs
                    text: "Guardar"
                    onClicked: {
                        var json=ta.text;
                        console.log(json)
                        var jsonIconos
                        var d = new Date(Date.now());
                        try {
                            jsonIconos =  JSON.parse(json);
                            var nAppsDir = (''+appsDir).replace('file:///', '')
                            var urlLauncherConfig = nAppsDir+'/'+'config-unik-launcher.json'
                            console.log('Grabando config en: '+urlLauncherConfig)
                            uk.setFile(urlLauncherConfig, json)

                            msgStatus.text = '['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+']: Configuración guardada.'
                            config.visible = false
                            reloadConfig()
                        } catch(e) {
                            console.log(e);
                            msgStatus.text = '['+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()+']:Json Parse error! '+e;
                        }
                    }
                }
                Text{
                    id: msgStatus
                    font.pixelSize: config.fs
                    color: app.c1
                    onTextChanged: {
                        ocultarMsg.start()
                    }
                    Timer{
                        id: ocultarMsg
                        running: false
                        repeat: false
                        interval: 3000
                        onTriggered: {
                            msgStatus.text = ''
                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tsave
        running: false
        repeat: false
        interval: 1500
        onTriggered: {
            saveConfig()
        }
    }
    FileDialog {
        id: fileDialogIcon
        visible: false
        //modality: fileDialogModal.checked ? Qt.WindowModal : Qt.NonModal
        title: "Seleccionar Imagen"
        selectExisting: true
        selectMultiple: false
        selectFolder: false
        nameFilters: [ "Archivos de Imagen (*.png *.jpg *.svg)", "Todos los Archivos (*)" ]
        selectedNameFilter: "All files (*)"
        sidebarVisible: true
        property var nindex
        onAccepted: {
            console.log("Imagen de Ícono: " + fileUrls)
            lm.setProperty(nindex, "ubic", fileUrls[0])
            saveConfig()
        }
        onRejected: { console.log("Rejected") }
    }

    Component.onCompleted: {
        reloadConfig()
    }
    function reloadConfig(){
        var json;
        var nAppsDir = (''+appsDir).replace('file:///', '')
        var urlLauncherConfig = nAppsDir+'/'+'config-unik-launcher.json'
        console.log("Buscando configuración del launcher en "+urlLauncherConfig)
        if(uk.fileExist(urlLauncherConfig)){
            console.log("Archivo de Configuración de "+appName+' existente')
            json = uk.getFile(urlLauncherConfig, true)
            console.log(json)
        }else{
            console.log("Archivo de Configuración de "+appName+' NO existente')
            json = '{"config":{"x": 300, "y": 300, "orientation":"v", "anchoBoton": "150", "fs":"18", "onTop":"true"},"icon0":{"appName":"unik-tools", "img": "http://codigosenaccion.com/apps/unik/img/config_unik.png"}}'
            uk.setFile(urlLauncherConfig, json)

        }
        ta.text = json
        var jsonIconos = JSON.parse(json)
        lm.clear()

        for(var i=0;i<Object.keys(jsonIconos).length;i++){
            var nameItem = Object.keys(jsonIconos)[i]
            console.log("Nombre de clave: "+nameItem)
            if(''+nameItem=='config'){
                gridIconos.orientation = jsonIconos[nameItem].orientation === 'v' ? ListView.Vertical : ListView.Horizontal

                config.fs = jsonIconos[nameItem].fs
                app.x = jsonIconos[nameItem].x
                app.y = jsonIconos[nameItem].y
                app.anchoBoton = jsonIconos[nameItem].anchoBoton
                if(jsonIconos[nameItem].onTop==='true'){
                    app.flags = Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
                }else{
                    app.flags = Qt.Window | Qt.FramelessWindowHint
                }

            }else{
                lm.append(lm.add(jsonIconos[nameItem].appName, jsonIconos[nameItem].img, jsonIconos[nameItem]))

            }
        }
        //posicionar()
        redim()
    }
    function saveConfig(){
        console.log("Grabando configuración")
        var cOr=app.estado===1?'v':'h';
        var json = '{"config":{"x": '+app.x+', "y": '+app.y+', "orientation":"'+cOr+'", "anchoBoton": "'+parseInt(anchoBoton)+'", "fs":"'+config.fs+'", "onTop":"'+app.onTop+'"}'
        for(var i=0; i< lm.count;i++){
            json+=',"icon'+i+'":{"appName":"'+lm.get(i).nombre+'", "img": "'+lm.get(i).ubic+'"}'
        }
        json+='}'
        var nAppsDir = (''+appsDir).replace('file:///', '')
        var urlLauncherConfig = nAppsDir+'/'+'config-unik-launcher.json'
        console.log("Archivo: "+urlLauncherConfig+' Datos: '+json)
        uk.setFile(urlLauncherConfig, json)
    }
    function posicionar(){
        if(gridIconos.orientation === ListView.Horizontal){
            gridIconos.orientation = ListView.Vertical
            /*app.width = app.anchoBoton
            app.height = (app.anchoBoton*lm.count+anchoBoton*0.15)<app.height ? app.anchoBoton*lm.count+anchoBoton*0.15 : Screen.height-anchoBoton*0.15*/
            app.estado = 1
        }else{
            gridIconos.orientation = ListView.Horizontal
            /*app.width = (app.anchoBoton*lm.count+anchoBoton*0.15)<app.width ? app.anchoBoton*lm.count+anchoBoton*0.15 : Screen.width-anchoBoton*0.15
            app.height = app.anchoBoton*/
            app.estado = 2
        }
        if(config.visible){
            app.width = config.width
            app.height = config.height
        }
        redim()
        tsave.restart()
    }
    function redim(){
        if(gridIconos.orientation === ListView.Vertical){
            //gridIconos.orientation = ListView.Vertical
            app.width = app.anchoBoton
            app.height = (app.anchoBoton*lm.count)<app.height ? app.anchoBoton*lm.count+anchoBoton*0.15 : Screen.height-anchoBoton*0.15
            app.estado = 1
        }else{
            //gridIconos.orientation = ListView.Horizontal
            app.width = (app.anchoBoton*lm.count)<Screen.width ? app.anchoBoton*lm.count+anchoBoton*0.15 : Screen.width
            app.height = app.anchoBoton
            app.estado = 2
        }
        if(config.visible){
            app.width = config.width
            app.height = config.height
        }
        tsave.restart()
    }

}
