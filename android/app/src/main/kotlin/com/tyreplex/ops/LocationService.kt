//package com.tyreplex.ops
//
////import android.app.Activity
////import android.os.Binder
////import android.util.Log
//import android.Manifest
//import android.app.Service
//import android.content.*
//import android.content.Context
//import android.content.Intent
//import android.content.pm.PackageManager
//import android.location.Location
//import android.location.LocationListener
//import android.location.LocationManager
//import android.os.Bundle
//import android.os.IBinder
//import android.util.Log
//import androidx.core.app.ActivityCompat
//import com.google.android.gms.location.*
//import java.util.*
//
////import androidx.core.content.ContextCompat
////import android.location.configuration.GooglePlayServicesConfiguration
////import android.location.configuration.LocationConfiguration
////import android.location.configuration.PermissionConfiguration
//
//
//class LocationService : Service(), LocationListener() {
//
////   override fun onCreate(savedInstanceState: Bundle?) {
////        super.onCreate(savedInstanceState)
////       getLocation()
////
//////        var serviceRunning = true
//////        Timer().schedule(object : TimerTask() {
//////            override fun run() {
//////                if (serviceRunning == true) {
//////                    getLocation()
////////                    updateNotification("I got updated!")
//////                }
//////            }
//////        }, 5000)
////    }
//
//    lateinit var locationManager: LocationManager
//    private var location: Location =""
//    var latitude: Double = 0.0
//    var longitude: Double = 0.0
//    private val locationPermissionCode = 2
//
//    fun GpsTracker(context: Context) {
//        this.Context = context
//        getLocation()
//    }
//
//    fun getLocation(): Location? {
//        try {
//            locationManager = Context.getSystemService(LOCATION_SERVICE) as LocationManager
//
//            // getting GPS status
//            isGPSEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
//
//            // getting network status
//            isNetworkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
//
//            if (!isGPSEnabled && !isNetworkEnabled) {
//                // no network provider is enabled
//            } else {
//                this.canGetLocation = true
//                // First get location from Network Provider
//                if (isNetworkEnabled) {
//                    //check the network permission
//                    if (ActivityCompat.checkSelfPermission(Context, Manifest.permission.ACCESS_FINE_LOCATION)
//                        !== PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(Context, Manifest.permission.ACCESS_COARSE_LOCATION)
//                        !== PackageManager.PERMISSION_GRANTED
//                    ) {
//                        ActivityCompat.requestPermissions(
//                            Context as Activity?,
//                            arrayOf<String>(
//                                android.Manifest.permission.ACCESS_FINE_LOCATION,
//                                Manifest.permission.ACCESS_COARSE_LOCATION
//                            ),
//                            101
//                        )
//                    }
//                    locationManager.requestLocationUpdates(
//                        LocationManager.NETWORK_PROVIDER,
//                        MIN_TIME_BW_UPDATES,
//                        MIN_DISTANCE_CHANGE_FOR_UPDATES, this
//                    )
//                    Log.d("Network", "Network")
//                    if (locationManager != null) {
//                        location = locationManager?.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
//                        if (location != null) {
//                            latitude = location.getLatitude()
//                            longitude = location.getLongitude()
//                        }
//                    }
//                }
//
//                // if GPS Enabled get lat/long using GPS Services
////                if (isGPSEnabled) {
////                    if (location == null) {
////                        //check the network permission
////                        if (ActivityCompat.checkSelfPermission(
////                                mContext,
////                                Manifest.permission.ACCESS_FINE_LOCATION
////                            ) !== PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
////                                mContext,
////                                Manifest.permission.ACCESS_COARSE_LOCATION
////                            ) !== PackageManager.PERMISSION_GRANTED
////                        ) {
////                            ActivityCompat.requestPermissions(
////                                mContext as Activity?,
////                                arrayOf<String>(
////                                    android.Manifest.permission.ACCESS_FINE_LOCATION,
////                                    Manifest.permission.ACCESS_COARSE_LOCATION
////                                ),
////                                101
////                            )
////                        }
////                        locationManager.requestLocationUpdates(
////                            LocationManager.GPS_PROVIDER,
////                            MIN_TIME_BW_UPDATES,
////                            MIN_DISTANCE_CHANGE_FOR_UPDATES, this
////                        )
////                        Log.d("GPS Enabled", "GPS Enabled")
////                        if (locationManager != null) {
////                            location = locationManager
////                                .getLastKnownLocation(LocationManager.GPS_PROVIDER)
////                            if (location != null) {
////                                latitude = location.getLatitude()
////                                longitude = location.getLongitude()
////                            }
////                        }
////                    }
////                }
//            }
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }
//        return location
//    }
//
//    override fun onBind(intent: Intent?): IBinder? {
//        return null
//    }
//
//    override fun onLocationChanged(location: Location?) {
//        latitude = location.getLatitude()
//        longitude = location.getLongitude()
//    }
//
//    override fun onProviderDisabled(provider: String?) {}
//
//    override fun onProviderEnabled(provider: String?) {}
//
//    override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {}
//
////    fun getLatitude(): Double {
////        if (location != null) {
////            latitude = location.getLatitude()
////        }
////
////        // return latitude
////        return latitude
////    }
////    fun getLongitude(): Double {
////        if (location != null) {
////            longitude = location.getLongitude()
////        }
////
////        // return longitude
////        return longitude
////    }
//
////    fun getLocation() {
////        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
//////        if ((ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED)) {
//////            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), locationPermissionCode)
//////        }
////        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 5f, this)
////    }
////    override fun onLocationChanged(location: Location) {
////        if (location != null) {
////            latitude = location.latitude
////            longitude = location.longitude
////            Log.d("Location Service", "location update $location")
////            Log.d("Location Service", "location update $latitude")
////            Log.d("Location Service", "location update $longitude")
////        }
////    }
////
//}
//
//
////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////class LocationService: Service() {
////    var counter = 0
////    var latitude: Double = 0.0
////    var longitude: Double = 0.0
////    private val TAG = "LocationService"
//////    private lateinit var locationManager: LocationManager
////
////    override fun onCreate() {
////        super.onCreate()
////        requestLocationUpdates()
////
////        }
////
////    fun requestLocationUpdates() {
//////        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
////        val request = LocationRequest()
////        request.setInterval(10000)
////        request.setFastestInterval(5000)
////        request.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY)
////        val client: FusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)
////
//////        val permission = ContextCompat.checkSelfPermission(
//////            this,
//////            Manifest.permission.ACCESS_FINE_LOCATION
//////        )
////
////            client.requestLocationUpdates(request, object : LocationCallback() {
////                override fun onLocationResult(locationResult: LocationResult) {
////                    val location: Location? = locationResult.getLastLocation()
////                    if (location != null) {
////                        latitude = location.latitude
////                        longitude = location.longitude
////                        Log.d("Location Service", "location update $location")
////                        Log.d("Location Service", "location update $latitude")
////                        Log.d("Location Service", "location update $longitude")
////                    }
////                }
////            }, null)
////
////    }
////
////    override fun onBind(intent: Intent?): IBinder? {
////        return null
////    }
////
////
////}
//
//
//
//
////++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////location library code
////class FlutterLocationService() : Service() {
////    companion object {
////        private const val TAG = "FlutterLocationService"
////
////        private const val ONGOING_NOTIFICATION_ID = 75418
////        private const val CHANNEL_ID = "flutter_location_channel_01"
////    }
////
////    // Binder given to clients
////    private val binder = LocalBinder()
////
////    // Service is foreground
////    private var isForeground = false
////
////    private var backgroundNotification: BackgroundNotification? = null
////
////    var locationManager: LocationManager? = null
////        private set
////
////    // Store result until a permission check is resolved
////    public var activity: Activity? = null
////
////
////    inner class LocalBinder : Binder() {
////        fun getService(): FlutterLocationService = this@FlutterLocationService
////    }
////
////    override fun onCreate() {
////        super.onCreate()
////        backgroundNotification = BackgroundNotification(
////            applicationContext,
////            CHANNEL_ID,
////            ONGOING_NOTIFICATION_ID
////        )
////    }
////
////    override fun onBind(intent: Intent?): IBinder? {
////        Log.d(TAG, "Binding to location service.")
////        return binder
////    }
////
////    override fun onUnbind(intent: Intent?): Boolean {
////        Log.d(TAG, "Unbinding from location service.")
////        return super.onUnbind(intent)
////    }
////
//////    override fun onDestroy() {
//////        Log.d(TAG, "Destroying service.")
//////
//////        locationManager?.cancel()
//////        locationManager = null
//////        backgroundNotification = null
//////
//////        super.onDestroy()
//////    }
////
////
////    fun enableBackgroundMode() {
////        if (isForeground) {
////            Log.d(TAG, "Service already in foreground mode.")
////        } else {
////            Log.d(TAG, "Start service in foreground mode.")
////
////
////            val locationConfiguration =
////                LocationConfiguration.Builder()
////                    .keepTracking(true)
////                    .askForPermission(
////                        PermissionConfiguration.Builder()
////                            .requiredPermissions(
////                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
////                                    arrayOf(
////                                        Manifest.permission.ACCESS_FINE_LOCATION,
////                                        Manifest.permission.ACCESS_BACKGROUND_LOCATION
////                                    )
////                                } else {
////                                    arrayOf(
////                                        Manifest.permission.ACCESS_FINE_LOCATION,
////                                    )
////                                }
////                            )
////                            .build()
////                    )
////                    .useGooglePlayServices(GooglePlayServicesConfiguration.Builder().build())
////                    .useDefaultProviders(DefaultProviderConfiguration.Builder().build())
////                    .build()
////
////            locationManager = LocationManager.Builder(applicationContext)
////                .activity(activity) // Only required to ask permission and/or GoogleApi - SettingsApi
////                .configuration(locationConfiguration)
////                .build()
////
////            locationManager?.get()
////
////
////            val notification = backgroundNotification!!.build()
////            startForeground(ONGOING_NOTIFICATION_ID, notification)
////
////            isForeground = true
////        }
////    }
////
////    fun disableBackgroundMode() {
////        Log.d(TAG, "Stop service in foreground.")
////        stopForeground(true)
////
////        locationManager?.cancel()
////
////        isForeground = false
////    }
////
////    fun changeNotificationOptions(options: NotificationOptions): Map<String, Any>? {
////        backgroundNotification?.updateOptions(options, isForeground)
////
////        return if (isForeground)
////            mapOf("channelId" to CHANNEL_ID, "notificationId" to ONGOING_NOTIFICATION_ID)
////        else
////            null
////    }
////
////
////    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
////        Log.d("Location", "onActivityResult")
////        locationManager?.onActivityResult(requestCode, resultCode, data)
////        return true
////    }
////
////    override fun onRequestPermissionsResult(
////        requestCode: Int,
////        permissions: Array<out String>,
////        grantResults: IntArray
////    ): Boolean {
////        locationManager?.onRequestPermissionsResult(requestCode, permissions, grantResults)
////        return true
////    }
////}
//
////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
////class Location : LocationListener() {
////
////       override fun onCreate(savedInstanceState: Bundle?) {
////            super.onCreate(savedInstanceState)
////            setContentView(R.layout.activity_main)
////            getLocation()
////        }
////
////    private lateinit var locationManager: LocationManager
////    private lateinit var tvGpsLocation: TextView
////    private val locationPermissionCode = 2
////
////        private fun getLocation() {
////            locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
////            if ((ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED)) {
////                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), locationPermissionCode)
////            }
////            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 5f, this)
////        }
////        override fun onLocationChanged(location: Location) {
////            tvGpsLocation = findViewById(R.id.textView)
////            tvGpsLocation.text = "Latitude: " + location.latitude + " , Longitude: " + location.longitude
////        }
//////        override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
//////            super.onRequestPermissionsResult(requestCode, permissions, grantResults)
//////            if (requestCode == locationPermissionCode) {
//////                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
////////                    Toast.makeText(this, "Permission Granted", Toast.LENGTH_SHORT).show()
//////                }
//////                else {
////////                    Toast.makeText(this, "Permission Denied", Toast.LENGTH_SHORT).show()
//////                }
//////            }
//////        }
////    }
