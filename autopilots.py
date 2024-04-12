

class auto_polits_mode:
    def __init__ (self,altitude,speed,engine_temp,air_fuel_ratio,fuel_type):
         self.altitude=altitude #feet
         self.speed=speed   # km/h
         self.engine_temp=engine_temp   ## degrees F
         self.air_fuel_ratio=air_fuel_ratio # assumed ratio
         self.fuel_type=fuel_type   #fuel_type
    def monitor_plane(self):
        print(f"Altitude: {altitude} feet")
        print(f"Speed: {speed} km/h")
        print(f"Engine Temperature: {engine_temp} degrees F")
        print(f"Air-Fuel Ratio: {air_fuel_ratio}:1")
        print(f"Fuel Type: {fuel_type}")
        if altitude > 310000 & altitude < 40000:
            print(f"Good: Stable Altitude {altitude} feet.....")
            if speed > 880 & speed < 920:
                print(f"Good: Stable speed {speed} speed.....")
            else:
                print(f"Warning: Speed out of range {speed} speed!")
        else:
             print(f"Warning: Altitude exceeds {altitude} feet!")

    def detect_anomalies(self):
        altitude_mini_max = (31000, 42000)  
        speed_mini_max = (880, 920) 
        engine_temp_max = 435
        fuel_ratio_mini_max= (12, 15) 
        fuel_type_var=("Kerosene or Jet Fuel")
        if altitude < altitude_mini_max[0] or altitude > altitude_mini_max[1]:
            print("Anomaly detected: Altitude is outside the normal range!")
        if speed < speed_mini_max[0] or speed > speed_mini_max[1]:
            print("Anomaly detected: Speed is outside the normal range!")
        if engine_temp > engine_temp_max:
            print("Anomaly detected: Engine temperature is too high!")
        if air_fuel_ratio < fuel_ratio_mini_max[0] or air_fuel_ratio > fuel_ratio_mini_max[1]:
            print("Anomaly detected: Air-fuel ratio is outside the normal range!")
        if fuel_type == fuel_type_var[0] or fuel_type == fuel_type_var[1]:
            print("Anomaly detected: fuel type is different!")


    def terrain_avoidance(self):
        altitude_avg = (31000, 42000)  
        safe_height = (altitude_avg[0] + altitude_avg[1]) / 2
        if safe_height < 35000:
            print(f"Adjusting flight path to increase altitude {safe_height} for terrain avoidance.")

    def navigate_to_nearest_airport(self):
        airports = {
            'Airport Chennai': {'latitude': 40.7128, 'longitude': -74.0060},
            'Airport Mumbai': {'latitude': 34.0522, 'longitude': -118.2437},
            'Airport Thoothukudi': {'latitude': 53.0572, 'longitude': -230.5727},
        }
        current_lat = 38.9072
        current_long = -77.0369
        nearest_airport = None
        min_distance = float('inf')
        for airport, coords in airports.items():
            distance = ((current_lat - coords['latitude'])**2 + (current_long - coords['longitude'])**2) ** 0.5
            if distance < min_distance:
                min_distance = distance
                nearest_airport = airport
        print(f"Navigating to the nearest airport: {nearest_airport}")



# Main function
def start():
    # Call monitor_plan
    a1.monitor_plane()
    # Call detect_anomalies or malfunction
    a1.detect_anomalies()
    # Call terrain_avoidance
    a1.terrain_avoidance()
    # Call navigate_to_nearest_airport
    a1.navigate_to_nearest_airport()

if __name__ == "__main__":
    altitude = 35000  # feet
    speed = 900  # km/h
    engine_temp = 400  # degrees F
    air_fuel_ratio = 14
    fuel_type="jet fuel" 
    a1=auto_polits_mode(altitude,speed,engine_temp,air_fuel_ratio,fuel_type)
    start()