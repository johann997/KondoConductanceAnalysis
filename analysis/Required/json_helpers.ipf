#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later



function get_hdfid(datnum)
	// Opens HDF5 file from current data folder and returns sweeplogs jsonID
	// Remember to JSON_Release(jsonID) or JSONXOP_release/A to release all objects
	// Can be converted to JSON string by using JSON_dump(jsonID)
	variable datnum
	variable fileid
	HDF5OpenFile /P=data fileid as "dat"+num2str(datnum)+".h5"
	return fileid
end



function fd_getoldAWG(S,datnum,[fastdac_num, kenner])
	// Function to get old values for AWG that is stored in hdf file with filenum
	struct AWGVars &S
	variable datnum, fastdac_num
	string kenner
	kenner = selectString(paramisdefault(kenner), kenner, "")
	
	variable sl_id, fd_id  //JSON ids
	fastdac_num = paramisdefault(fastdac_num) ? 1 : fastdac_num

	if(fastdac_num != 1)
		abort "WARNING: This is untested... remove this abort if you're feeling lucky!"
	endif

	sl_id = get_sweeplogs(datnum, kenner=kenner)  // Get Sweep_logs JSON;
	fd_id = getJSONXid(sl_id, "FastDAC "+num2istr(fastdac_num)) // Get FastDAC JSON from Sweeplogs

	// Get variable parts

	//	JSONXOP_GetValue/V fd_id, "/AWG/initialized"
	//	S.initialized=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/AWG_used"
	S.use_AWG=V_value

	S.lims_checked=0; //always 0

	JSONXOP_GetValue/V fd_id, "/AWG/waveLen"
	S.waveLen=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/numADCs"
	S.numADCs=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/samplingFreq"
	S.samplingFreq=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/measureFreq"
	S.measureFreq=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/numWaves"
	S.numWaves=V_value

	JSONXOP_GetValue/V fd_id, "/AWG/numCycles"
	S.numCycles=V_value


	JSONXOP_GetValue/V fd_id, "/AWG/numSteps"
	S.numSteps=V_value

	JSONXOP_GetValue/T fd_id, "/AWG/AW_Waves"
	S.AW_waves=S_value

	JSONXOP_GetValue/T fd_id, "/AWG/AW_Dacs"
	S.AW_dacs=S_value

	JSONXOP_Release /A  //Clear all stored JSON strings

end



function fd_getScanVars(S,datnum,[fastdac_num])
	// Function to get old values for AWG that is stored in hdf file with filenum
	struct ScanVars &S
	variable datnum, fastdac_num
	variable sl_id, fd_id  //JSON ids
	fastdac_num = paramisdefault(fastdac_num) ? 1 : fastdac_num

	if(fastdac_num != 1)
		abort "WARNING: This is untested... remove this abort if you're feeling lucky!"
	endif

	sl_id = get_sweeplogs(datnum)  // Get Sweep_logs JSON;
	fd_id = getJSONXid(sl_id, "FastDAC "+num2istr(fastdac_num)) // Get FastDAC JSON from Sweeplogs


	// Get variable parts


	JSONXOP_GetValue/V fd_id, "/MeasureFreq"
	S.MeasureFreq=V_value

	
	JSONXOP_Release /A  //Clear all stored JSON strings

end


function fd_getmeasfreq(datnum,[fastdac_num])
	// Function to get old h5 values for measurement frequency
	variable datnum, fastdac_num
	variable sl_id, fd_id  //JSON ids
	variable freq
	fastdac_num = paramisdefault(fastdac_num) ? 1 : fastdac_num

	if(fastdac_num != 1)
		abort "WARNING: This is untested... remove this abort if you're feeling lucky!"
	endif

	sl_id = get_sweeplogs(datnum)  // Get Sweep_logs JSON;
	fd_id = getJSONXid(sl_id, "FastDAC "+num2istr(fastdac_num)) // Get FastDAC JSON from Sweeplogs

	// Get variable parts

	//	JSONXOP_GetValue/V fd_id, "/AWG/initialized"
	//	S.initialized=V_value

	JSONXOP_GetValue/V fd_id, "MeasureFreq"
	freq=V_value

	JSONXOP_Release /A  //Clear all stored JSON strings
	
	return freq

end
