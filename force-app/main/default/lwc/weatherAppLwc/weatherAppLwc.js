import { LightningElement,wire,track } from 'lwc';
import callWeatherApi from '@salesforce/apex/WeatherApiLwc.callWeatherApi';
import getCurrentUserProfile from '@salesforce/apex/FindCurrentProfileApex.getCurrentProfile';


export default class WeatherAppLwc extends LightningElement {

    weatherData 
    cityName
    countryName 
    currentTempInC
    currentTempInF
  @track currentTemp
    currentWeather 
    currentUserProfile
    imageIcon




    @wire (callWeatherApi)
	callWeatherApi({data, error}){
		if(data) {
            this.cityName = data.location.name
            this.countryName = data.location.country
            this.currentTempInC = data.current.temp_c
            this.currentTempInF = data.current.temp_f
            this.currentWeather  = data.current.condition.text
            this.imageIcon = data.current.condition.icon
            this.currentTemp = this.currentTempInC

            this.weatherData = data
			//console.log("data-->"+JSON.stringify(data))
            console.log("data--->"+data.current.temp_c)
            console.log("data of text-->"+this.currentWeather)
            console.log("Current Temperature in C "+this.currentTemp)
		}else {
			
		}
	}



    searchInputOnKeyUp(event){

        console.log("here we click")
    }


    changeTempToF(event){
        console.log("event called out")

        this.currentTemp = this.currentTempInF


    }

    changeTempToC(event){
        console.log("event called out")

        this.currentTemp = this.currentTempInC


    }




}