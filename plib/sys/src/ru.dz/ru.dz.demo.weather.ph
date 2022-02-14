/**
 *
 * Phantom OS - Phantom language library
 *
 * Copyright (C) 2005-2019 Dmitry Zavalishin, dz@dz.ru
 *
 * Simple weater widget
 *
 *
**/

package .ru.dz.demo;

import .phantom.os;
import .internal.io.tty;
import .internal.window;
import .internal.bitmap;
import .internal.tcp;
import .internal.connection;
import .internal.directory;
import .internal.long;
//import .ru.dz.phantom.system.runnable;

attribute const * ->!;

// graph color: 180 R, 205 G, 147 B
// ABGR hex = 0xFF93CDB4

class weather
{
    var i : int;
    var wbmp : .internal.bitmap[];

    var win : .internal.window;
    var sleep : .internal.connection;
    //var curl : .internal.connection;
    var http : .internal.tcp;

	//var temperature : .internal.string;
	var itemp : .internal.long;

	var xpos : int;
	var ypos : int;

    var stepNo : int;



    var j_point1 : .internal.directory;
    var p1_x : .internal.long;
    var p1_y : .internal.long;
    var p1_val : .internal.long;
    var p1_dir : .internal.string;


    var j_point2 : .internal.directory;
    var p2_x : .internal.long;
    var p2_y : .internal.long;
    var p2_val : .internal.long;
    var p2_dir : .internal.string;


    var j_point3 : .internal.directory;
    var p3_x : .internal.long;
    var p3_y : .internal.long;
    var p3_val : .internal.long;
    var p3_dir : .internal.string;


    void run(var console : .internal.io.tty)
    {
        var bmp : .internal.bitmap;
        var bmpw : .internal.bitmap;
        var json_string : .internal.string;
        var json : .internal.directory;

		//console.putws("Weather win: init\n");

        stepNo = 0;

        bmp = new .internal.bitmap();
        bmp.loadFromString(getBackgroundImage());
        
        win = new .internal.window();

        win.setWinPosition(200,100);
        //win.setWinSize( 374, 268 );

        win.setTitle("Weather");
        //win.setFg(0xFF000000); // black
		//win.setBg(0xFFcce6ff); // light cyan

        win.setFg(0xFF93CDB4); // light green
		win.setBg(0xFFccccb4); // light milk

        win.clear();
		win.drawImage( 0, 0, bmp );
		//win.drawString( 250, 250, "T =" );


        drawInfoBar();

        //loadImages();
        // bmpw = new .internal.bitmap();
        // bmpw.loadFromString(import "../resources/backgrounds/weather_sun_sm.ppm");
        // win.drawImage( 17, 102, bmpw );

        win.update();

		//console.putws("Weather win: done init\n");

		sleep = new .internal.connection();
        sleep.connect("tmr:");

        http = new .internal.tcp ();
		//curl = new .internal.connection();
		//curl.connect("url:http://smart.:8080/rest/items/Current_Outdoor_Air_Temp/state");

		/*
		temperature = curl.block(null, 0);
		console.putws("Weather win: curl = ");
		console.putws(temperature);
		console.putws("\n");
		win.drawString( 280, 240, temperature );
		*/

        xpos = 17;

        while(1)
        {
			console.putws("Weather win: curl\n");
            //temperature = curl.block(null, 0);

            // json_string = http.curl( "http://api.weather.yandex.ru/v1/forecast?extra=true&limit=1", "X-Yandex-API-Key: 7bdab0b4-2d21-4a51-9def-27793258d55d\r\n" );


            // Getting data from the server

            json_string = http.curl( "http://192.168.31.231:80/weather", "" );
            // json_string = "{\"p1\":{\"dir\":\"NW\",\"val\":10,\"x\":50,\"y\":50},\"p2\":{\"dir\":\"NW\",\"val\":20,\"x\":200,\"y\":50},\"p3\":{\"dir\":\"W\",\"val\":15,\"x\":50,\"y\":200}}";


			console.putws(json_string);


            json = json_string.parseJson();

            /*
            j_point1 = json.get("p1");
            p1_x = j_point1.get("x");
            p1_y = j_point1.get("y");
            p1_dir = j_point1.get("dir");
            p1_val = j_point1.get("val");


            j_point2 = json.get("p2");
            p2_x = j_point2.get("x");
            p2_y = j_point2.get("y");
            p2_dir = j_point2.get("dir");
            p2_val = j_point2.get("val");


            j_point3 = json.get("p3");
            p3_x = j_point3.get("x");
            p3_y = j_point3.get("y");
            p3_dir = j_point3.get("dir");
            p3_val = j_point3.get("val");
            */


			console.putws(json_string);

            //json = (.internal.directory)json_string.parseJson();
            // json = json_string.parseJson();
            // jtmp = json.get("fact");
            //temperature = jtmp.get("temp").toString();
            // itemp = jtmp.get("temp");
                
			console.putws("Weather win: curl = ");
            //console.putws(temperature);
            // console.putws(itemp.toString());

            /*
            console.putws("\nval=");
            console.putws(p1_val.toString());
            console.putws("\ndir=");
            console.putws(p1_dir);
            console.putws("\nx=");
            console.putws(castLongToInt(p1_x).toString());
            console.putws("\ny=");
            console.putws(castLongToInt(p1_y).toString());

            var temp_temp_string : .internal.string;
            temp_temp_string = p1_x.toString();
            var temp_temp_len : int;
            temp_temp_len = temp_temp_string.length();

            console.putws("long.toString().length()=");
            console.putws(temp_temp_len.toString());
            console.putws("\n");
            */

			console.putws("\n");

			//win.drawImage( 0, 0, bmp );
            //win.drawImage( 17, 102, bmpw );

            win.drawImagePart( 0, 0, bmp, 250, 240, 120, 22 );

            // Outputing data

            
            win.clear();
            win.drawImage( 0, 0, bmp );

            win.setFg(0xFF93CDB4); // light green
		    win.setBg(0xFFccccb4); // light milk

            drawInfoFromData(json, "p1");
            drawInfoFromData(json, "p2");
            drawInfoFromData(json, "p3");
            drawInfoBar();

            win.update();

            /*
            win.setFg(0); // black
			win.drawString( castLongToInt(p1_x), castLongToInt(p1_y), p1_val.toString() );
            win.setFg(0); // black
			win.drawString( castLongToInt(p1_x), castLongToInt(p1_y) + 15, p1_dir );

            win.setFg(0); // black
			win.drawString( castLongToInt(p2_x), castLongToInt(p2_y), p2_val.toString() );
            win.setFg(0); // black
			win.drawString( castLongToInt(p2_x), castLongToInt(p2_y) + 15, p2_dir );

            win.setFg(0); // black
			win.drawString( castLongToInt(p3_x), castLongToInt(p3_y), p3_val.toString() );
            win.setFg(0); // black
			win.drawString( castLongToInt(p3_x), castLongToInt(p3_y) + 15, p3_dir );

			// win.drawString( p1_x, p1_y, p1_val.toString() );
			// win.drawString( p1_x, p1_y + 30, p1_dir );
// 
			// win.drawString( p1_x, p1_y, p1_val.toString() );
			// win.drawString( p1_x, p1_y + 30, p1_dir );

            */

            

            //itemp = temperature.toInt();
            // ypos = 15 + (itemp * 2);

            // win.setFg(0xFF93CDB4); // light green
            // if( ypos < 70 )
            //     win.fillBox( xpos, ypos, 2, 2 );


            stepNo = stepNo + 1;


			console.putws("Weather win: sleep\n");

            sleep.block(null, 5);

			console.putws("Weather win: out of sleep\n");

            xpos = xpos+1;
            if( xpos > 358 ) xpos = 17;
		}

    }

    void drawInfoBar() {
        win.drawString(0, 0, "Update #");
        win.drawString(70, 0, stepNo.toString());
    }

    void drawInfoFromData(var json : .internal.directory, var id: .internal.string) {

        var point : .internal.directory;
        var p_x : .internal.long;
        var p_y : .internal.long;
        var p_val : .internal.long;
        var p_dir : .internal.string;

        point = json.get(id);
        p_x = point.get("x");
        p_y = point.get("y");
        p_dir = point.get("dir");
        p_val = point.get("val");

        win.drawString( castLongToInt(p_x), castLongToInt(p_y), p_val.toString() );
        win.drawString( castLongToInt(p_x), castLongToInt(p_y) + 15, p_dir );
    }

    int castLongToInt(var val_long : .internal.long)
    {
        var tmp_str : .internal.string;
        var val_int : int;

        tmp_str = "12345";
        tmp_str = val_long.toString();

        val_int = tmp_str.toInt();

        return val_int;
    }

	.internal.string getTemperature()
	{
		//var url : .internal.string;

		//url = "http://smart.:8080/rest/items/Current_Outdoor_Air_Temp/state";

	}


    .internal.string getBackgroundImage()
    {
        return import "../resources/demo2/inno_map.ppm" ;
        //return import "../resources/backgrounds/snow_weather.ppm" ;
    }


	.internal.bitmap loadImages()
	{
        wbmp[7] = new .internal.bitmap();
        wbmp[7].loadFromString(import "../resources/backgrounds/weather_sun_sm.ppm");

/*
        wbmp[0] = new .internal.bitmap();
        wbmp[0].loadFromString(import "../resources/backgrounds/weather_clouds.ppm");

        wbmp[1] = new .internal.bitmap();
        wbmp[1].loadFromString(import "../resources/backgrounds/weather_grad.ppm");

        wbmp[2] = new .internal.bitmap();
        wbmp[2].loadFromString(import "../resources/backgrounds/weather_ice.ppm");

        wbmp[3] = new .internal.bitmap();
        wbmp[3].loadFromString(import "../resources/backgrounds/weather_lightning.ppm");

        wbmp[4] = new .internal.bitmap();
        wbmp[4].loadFromString(import "../resources/backgrounds/weather_moon.ppm");

        wbmp[5] = new .internal.bitmap();
        wbmp[5].loadFromString(import "../resources/backgrounds/weather_rain.ppm");

        wbmp[6] = new .internal.bitmap();
        wbmp[6].loadFromString(import "../resources/backgrounds/weather_snow.ppm");


        wbmp[8] = new .internal.bitmap();
        wbmp[8].loadFromString(import "../resources/backgrounds/weather_wind.ppm");
*/

	}
	
};

