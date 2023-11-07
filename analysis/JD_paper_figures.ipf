#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>


function beautify_figure(figure_name)
	string figure_name
	ModifyGraph /W=$figure_name mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
end


function save_figure(figure_name)
	string figure_name
	
	string png_name = figure_name + ".png"
//	string data
	
//	PathInfo data
//	print ParseFilePath(1, S_path, ":", 1, 0)
//	string /G S_path
//	string file_path = ParseFilePath(1, S_path, ":", 1, 0) + "Figures:"
	string file_path = "Macintosh HD:Users:johanndrayne:Documents:Work:QDEV:_EntropyConductancePaper:IGORAnalysis:IGOR_Figures:"
	
	SavePICT/P=file_path/E=-5/RES=1000/o as png_name
end





function figure_C()
	///// SPRING CONDUCTANCE AND TRANSITION DATA ///// 
//	string datnums = "6079;6088;6085;6082"; string gamma_type = "high"// high gamma
//	string datnums = "6080;6089;6086;6083"; string gamma_type = "mid" // mid gamma
	string datnums = "6081;6090;6087;6084"; string gamma_type = "low" // low gamma
	
//	string datnums = "6100;6097;6094;6091"; string gamma_type = "high" // high gamma :: high field
	
//	string datnums = "6225;6234;6231;6228"; string gamma_type = "high" // high gamma :: 2-3 transition
//	string datnums = "6226;6235;6232;6229"; string gamma_type = "high" // high gamma :: 2-3 transition

	string e_temps = "23;100;300;500"
	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
	string colour, e_temp
	variable red, green, blue
	
	int global_fit_conductance = 1
	
	variable num_dats = ItemsInList(datnums, ";")
	
	///// ZAP NANs /////
	string ct_datnum, ct_wavename
	int i 
	for (i=0; i<num_dats; i++)
		ct_datnum = stringfromlist(i, datnums)
		ct_wavename = "dat" + ct_datnum + "_cs_cleaned_avg"
		zap_NaNs($ct_wavename, overwrite=1)
	endfor
	
	///// RUN GLOBAL FIT /////
	variable cond_chisq, occ_chisq, condocc_chisq
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(e_temps, datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_conductance=1, fit_entropy=0, fit_entropy_dats="")	
	
	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 

	string cond_avg, cond_avg_fit
	string trans_avg, trans_avg_fit
	string occ_avg, occ_avg_fit
	
	string occupation_coef_name
	
	string legend_text = ""
	variable datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, datnums))
		e_temp = stringfromlist(i, e_temps)
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		if (global_fit_conductance == 1)
			cond_avg_fit = "GFit_" + cond_avg
		else
			cond_avg_fit = "fit_" + cond_avg
		endif
		
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		if (global_fit_conductance == 1)
			trans_avg_fit = "fit_" + trans_avg
		else
			trans_avg_fit = "GFit_" + trans_avg
		endif
		
		occ_avg = trans_avg + "_occ"
		occ_avg_fit = trans_avg_fit + "_occ"
		
		legend_text = legend_text + "\\s(" + trans_avg_fit +  ") " +  e_temp + "mK\r"
		
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		//////////////////////////////////////////
		///// ADDING CONDUCTION VS SWEEPGATE /////
		//////////////////////////////////////////
		AppendToGraph /W=figure_ca /L=l3/B=b3 $cond_avg; AppendToGraph /W=figure_ca /L=l3/B=b3 $cond_avg_fit;
		ModifyGraph /W=figure_ca mode($cond_avg)=2, lsize($cond_avg)=1, rgb($cond_avg)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($cond_avg_fit)=0, lsize($cond_avg_fit)=2, rgb($cond_avg_fit)=(red,green,blue)
		
		
		//////////////////////////////////////////
		///// ADDING OCCUPATION VS SWEEPGATE /////
		//////////////////////////////////////////
		///// Appending traces to panel ca /////
		AppendToGraph /W=figure_ca /L=l2/B=b2 $trans_avg; AppendToGraph /W=figure_ca /L=l2/B=b2 $trans_avg_fit;
		ModifyGraph /W=figure_ca mode($trans_avg)=2, lsize($trans_avg)=1, rgb($trans_avg)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($trans_avg_fit)=0, lsize($trans_avg_fit)=2, rgb($trans_avg_fit)=(red,green,blue)
		
		///// Appending traces to panel cb /////
		AppendToGraph /W=figure_ca /L=l4/B=b4 $occ_avg; AppendToGraph /W=figure_ca /L=l4/B=b4 $occ_avg_fit;
		ModifyGraph /W=figure_ca mode($occ_avg)=2, lsize($occ_avg)=1, rgb($occ_avg)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($occ_avg_fit)=0, lsize($occ_avg_fit)=2, rgb($occ_avg_fit)=(red,green,blue)		
		
		
		///////////////////////////////////////////
//		///// ADDING CONDUCTION VS OCCUPATION /////
//		///////////////////////////////////////////
		variable numpts_occupation = 10000
		create_x_wave($occ_avg)
		wave x_wave
		
		////////////////////////////////////
		///// interpolating data waves /////
		////////////////////////////////////
		variable minx, maxx
		[minx, maxx] = find_overlap_mask($(trans_avg+"_mask"), $(trans_avg+"_mask"))
		
		// interpolating occupation to have higher density of points
		string cond_vs_occ_data_wave_name_x = occ_avg + "_interp"
		interpolate_wave(cond_vs_occ_data_wave_name_x, $occ_avg, numpts_to_interp=10000)
		
		// interpolating conduction to have data at same x points as occuptaion data
		string cond_vs_occ_data_wave_name_y = cond_avg + "_interp"
		interpolate_wave(cond_vs_occ_data_wave_name_y, $cond_avg, wave_to_duplicate=$cond_vs_occ_data_wave_name_x)
		
		// deleting points outside of mask
		delete_points_from_x($cond_vs_occ_data_wave_name_x, minx, maxx)
		delete_points_from_x($cond_vs_occ_data_wave_name_y, minx, maxx)
		
		
		///////////////////////////////////
		///// interpolating fit waves /////
		///////////////////////////////////
		string cond_vs_occ_fit_wave_name_x = occ_avg_fit + "_interp"
		interpolate_wave(cond_vs_occ_fit_wave_name_x, $occ_avg_fit, numpts_to_interp=10000)
		
		string cond_vs_occ_fit_wave_name_y = cond_avg_fit + "_interp"
		interpolate_wave(cond_vs_occ_fit_wave_name_y, $cond_avg_fit, wave_to_duplicate=$cond_vs_occ_fit_wave_name_x)

		delete_points_from_x($cond_vs_occ_fit_wave_name_x, minx, maxx)
		delete_points_from_x($cond_vs_occ_fit_wave_name_y, minx, maxx)

		AppendToGraph /W=figure_ca /L=left/B=bottom $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x; AppendToGraph /W=figure_ca /L=left/B=bottom $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
		ModifyGraph /W=figure_ca mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=1, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(red,green,blue)
	endfor
	
	///// axis labelling goes from top plot to bottom plot
	///// [b3, l3] [b2, l2] [bottom left]
	
	
	///// setting y-scale of axis /////
	ModifyGraph /W = figure_ca axisEnab(l3)={0.72, 1.0}
	ModifyGraph /W = figure_ca axisEnab(l2)={0.43, 0.71}
	ModifyGraph /W = figure_ca axisEnab(left)={0.0, 0.28}
	SetAxis /W=figure_ca left 0,*
	SetAxis /W=figure_ca bottom 0,1
	
//	ModifyGraph /W = figure_ca axisEnab(l4)={0.57-0.05, 0.57+0.05}
//	ModifyGraph /W = figure_ca axisEnab(b4)={0.1,0.4}
	ModifyGraph /W=figure_ca  axisEnab(l4)={0.6,0.7},freePos(l4)=-20
	ModifyGraph axisEnab(b4)={0.055,0.2},freePos(b4)={0,l4}
	
	
	///// setting x-axis in line with y-axis /////
	ModifyGraph /W = figure_ca freePos(b2)={0,l3}
	ModifyGraph /W = figure_ca freePos(b3)={0,l2}
		
	///// remove label from b2 /////
	ModifyGraph /W = figure_ca noLabel(b2)=2
	
	ModifyGraph /W = figure_ca freePos(l2)=0
	ModifyGraph /W = figure_ca freePos(l3)=0
	
	ModifyGraph /W = figure_ca noLabel(b4)=2
	ModifyGraph /W = figure_ca noLabel(l4)=2
	
	///// setting  axis labels /////
	Label /W=figure_ca l3 "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	Label /W=figure_ca l2 "Current (nA)"
	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Label /W=figure_ca bottom "Occupation (.arb)"
	Label /W=figure_ca b3 "Sweep Gate (mV)"
	
	///// off-setting labels from the axis /////
	ModifyGraph /W=figure_ca lblPos(l2)=150
	ModifyGraph /W=figure_ca lblPos(l3)=150
	ModifyGraph /W=figure_ca lblPos(left)=150
	ModifyGraph /W=figure_ca lblPos(bottom)=80
	ModifyGraph /W=figure_ca lblPos(b3)=80
	
	
	///// adding legend /////
	Legend/W=figure_ca/C/N=legend_figc/J/A=LT legend_text

	beautify_figure("figure_ca")
end



function figure_D()
	string low_gamma_low_field = "6081"
	string mid_gamma_low_field = "6080"
	string high_gamma_low_field = "6079"
	
	string high_gamma_high_field = "6100"
	string high_gamma_23_transition = "6225"
	
	string base_y_data_name = "_dot_cleaned_avg_interp"
	string base_x_data_name = "_cs_cleaned_avg_occ_interp"
	


	Display; KillWindow /Z figure_da; DoWindow/C/O figure_da

	string y_data_name, x_data_name
	string y_fit_name, x_fit_name
	
	// black :: "0,0,0"
	// green :: "24158,34695,23901"
	// yellow :: "52685,33924,12336"
	// red :: "47802,0,2056"
	// blue :: "14906,27499,34438"
	variable red, green, blue
	string datnum
	///////////////////////////////
	///// low gamma low field /////
	///////////////////////////////
	datnum = low_gamma_low_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	red = 24158; green = 34695; blue = 23901
	AppendToGraph /W=figure_da /L=l2/B=b2 $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=l2/B=b2 $y_fit_name vs $x_fit_name;
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	
	///////////////////////////////
	///// mid gamma low field /////
	///////////////////////////////
	datnum = mid_gamma_low_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	red = 52685; green = 33924; blue = 12336
	AppendToGraph /W=figure_da /L=l2/B=b2 $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=l2/B=b2 $y_fit_name vs $x_fit_name;
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	
	///////////////////////////////
	///// high gamma low field fig a/////
	///////////////////////////////
	datnum = high_gamma_low_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	red = 47802; green = 0; blue = 2056
	AppendToGraph /W=figure_da /L=l2/B=b2 $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=l2/B=b2 $y_fit_name vs $x_fit_name;
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	
	///////////////////////////////
	///// high gamma low field figb /////
	///////////////////////////////
	datnum = high_gamma_low_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	AppendToGraph /W=figure_da /L=left/B=bottom $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=left/B=bottom $y_fit_name vs $x_fit_name;

	y_data_name = y_data_name + "#1"
	y_fit_name = y_fit_name + "#1"
	
	x_data_name = x_data_name + "#1"
	x_fit_name = x_fit_name + "#1"
	
	
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	///////////////////////////////
	///// high gamma low field fig c/////
	///////////////////////////////
	datnum = high_gamma_low_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	AppendToGraph /W=figure_da /L=l1/B=b1 $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=l1/B=b1 $y_fit_name vs $x_fit_name;
	
	y_data_name = y_data_name + "#2"
	y_fit_name = y_fit_name + "#2"
	
	x_data_name = x_data_name + "#2"
	x_fit_name = x_fit_name + "#2"
	
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	///////////////////////////////
	///// high gamma high field /////
	///////////////////////////////
	datnum = high_gamma_high_field
	y_data_name = "dat" + datnum + base_y_data_name
	y_fit_name = "Gfit_dat" + datnum + base_y_data_name
	
	x_data_name = "dat" + datnum + base_x_data_name
	x_fit_name = "fit_dat" + datnum + base_x_data_name
	
	red = 14906; green = 27499; blue = 34438
	AppendToGraph /W=figure_da /L=left/B=bottom $y_data_name vs $x_data_name; AppendToGraph /W=figure_da /L=left/B=bottom $y_fit_name vs $x_fit_name;
	ModifyGraph /W=figure_da mode($y_data_name)=2, lsize($y_data_name)=1, rgb($y_data_name)=(red,green,blue)
	ModifyGraph /W=figure_da mode($y_fit_name)=0, lsize($y_fit_name)=2, rgb($y_fit_name)=(red,green,blue)
	
	//////////////////////////////
	///// beautifying figure /////
	//////////////////////////////
	///// setting figure a)
	SetAxis /W=figure_da b2 0,1
	SetAxis /W=figure_da l2 0,*
	ModifyGraph /W = figure_da axisEnab(l2)={0.55, 1.0}
	ModifyGraph /W = figure_da freePos(l2)={0,bottom},freePos(b2)={0,l2}
	
	
	///// setting figure b)
	SetAxis /W=figure_da bottom 0,1
	SetAxis /W=figure_da left 0,*
	ModifyGraph /W = figure_da axisEnab(left)={0, 0.5}
	ModifyGraph /W = figure_da axisEnab(bottom)={0, 0.45}
	
	///// setting figure c)
	SetAxis /W=figure_da b1 0,1
	SetAxis /W=figure_da l1 0,*
	ModifyGraph /W = figure_da axisEnab(l1)={0,0.45},axisEnab(b1)={0.55,1}
	ModifyGraph /W = figure_da freePos(l1)={0,b1},freePos(b1)={0,l1}

	///// off-setting labels from the axis /////
	ModifyGraph /W=figure_da lblPos(l2)=50
	ModifyGraph /W=figure_da lblPos(l1)=50
	ModifyGraph /W=figure_da lblPos(left)=50
//	ModifyGraph /W=figure_ca lblPos(bottom)=80
//	ModifyGraph /W=figure_ca lblPos(b3)=80

	beautify_figure("figure_da")
//	save_figure("figure_da")
end



function etemp_test()
	string gamma_over_temp_type = "high"
	string datnums = "6079;6088;6085;6082" // high gamma
//	run_clean_average_procedure(datnums=datnums)
	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
	
	string base_temps = ";100;300;500"
	string global_temps
	
	variable num_temperatures = 20
	
	make /o/n=(num_temperatures) e_temps
	wave e_temps
	
	e_temps = x
	e_temps /= num_temperatures
	e_temps *= 20
	e_temps += 12
	
	make /o/n=(num_temperatures) cond_chisq_wave; wave cond_chisq_wave
	make /o/n=(num_temperatures) occ_chisq_wave; wave occ_chisq_wave	
	make /o/n=(num_temperatures) condocc_chisq_wave; wave condocc_chisq_wave
	variable cond_chisq, occ_chisq, condocc_chisq
	
	variable i
	for (i=0; i < num_temperatures; i++)
		global_temps = num2str(e_temps[i]) + base_temps
		[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(global_temps, datnums, gamma_over_temp_type)
		
		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
		
		cond_chisq_wave[i] = cond_chisq
		occ_chisq_wave[i] = occ_chisq
		condocc_chisq_wave[i] = condocc_chisq
	endfor
	
	display
	AppendToGraph/L cond_chisq_wave vs e_temps
	AppendToGraph/R occ_chisq_wave vs e_temps
//	AppendToGraph/R /L=l2, condocc_chisq_wave vs e_temps
	
	Label bottom "Electron Temp (mK)"
	Label left "Chi Squared Conductance"
	Label right "Chi Squared Occupation"
	ModifyGraph axRGB(left)=(65535,0,0),tlblRGB(left)=(65535,0,0),alblRGB(left)=(65535,0,0)
	
	ModifyGraph rgb(occ_chisq_wave)=(0,0,0), gFont="Calibri", gfSize=14
end



//function run_global_fit_wrapper(variable baset, string datnums, string gamma_over_temp_type, [variable global_fit_conductance])
//	variable cond_chisq, occ_chisq, condocc_chisq
//	
//	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data
////	run_clean_average_procedure(datnums=datnums)
////	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
//	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type, global_fit_conductance = global_fit_conductance)
//	
//	print "Conduction chisq = " + num2str(cond_chisq)
//	print "Occupation chisq = " + num2str(occ_chisq)
//end


function fit_charge_transition_entropy([global_temps, gamma_type])
	string global_temps, gamma_type
	global_temps = selectString(paramisdefault(global_temps), global_temps, "22.5;90;275;400") // temperatures used for global fitting
	gamma_type = selectString(paramisdefault(gamma_type), gamma_type, "low") // used to define starting parameters for global fit
	

	// SPRING EXPERIMENT // 
//	string entropy_datnums = "6385"; string global_datnums = "6079;6088;6085;6082"; gamma_type = "high" // 1000uV bias
	string entropy_datnums = "6385"; string global_datnums = "6081;6090;6087;6084"; gamma_type = "low" // 1000uV bias
	
	///// AUTUMN EXPERIMENT /////
//	string entropy_datnums = "1281"; string global_datnums = "1285;1297;1293;1289"; gamma_type = "low"
//	string entropy_datnums = "1282"; string global_datnums = "1286;1298;1294;1290"; gamma_type = "low"
//	string entropy_datnums = "1283"; string global_datnums = "1287;1299;1295;1291"; gamma_type = "mid"; info_mask_waves("1283", base_wave_name="_cs_cleaned_avg")
//	string entropy_datnums = "1284"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1284", base_wave_name="_cs_cleaned_avg") // 100uV bias
//	string entropy_datnums = "1372"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 50uV bias
//	string entropy_datnums = "1373"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 250uV bias
//	string entropy_datnums = "1374"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 500uV bias
//	string entropy_datnums = "1439"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 1000uV bias
//	string entropy_datnums = "1473"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 50uV bias :: symmetric

//	string entropy_datnums = "1505"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 1000uV bias

	global_temps = "22.5;100;300;500"
//	global_temps = "22.5;90;275;400"

//	global_temps = "22.5;275;400"
	variable num_points_in_entropy = 68 //25
	variable divide_all_data = 1
	variable centre_transition_repeats = 0
	variable global_fit_conductance = 0
	///// DONT CHANGE ANYMORE ///// 



	variable num_global_datnums = ItemsInList(global_datnums, ";")
	string ct_datnum, ct_wavename
	string dot_wavename


	///// CREATE 1D DATA FROM TRANSITION /////
	int i 
	for (i=0; i<num_global_datnums; i++)
	
		ct_datnum = stringfromlist(i, global_datnums)
		ct_wavename = "dat" + ct_datnum + "cscurrent_2d"
		
		
		// average conductance data
		if (global_fit_conductance == 1)
			dot_wavename = "dat" + ct_datnum + "dotcurrent_2d"
//			resampleWave($dot_wavename, 600)
			master_cond_clean_average($dot_wavename, 0, "dat", alternate_bias=1)
		endif
		
		closeallgraphs()
		
		wave ct_wave = $ct_wavename
		ct_wave[][] = ct_wave[p][q]/divide_all_data
//		resampleWave($ct_wavename, 600)
		string avg_ct_name = "dat" + ct_datnum + "_cs_cleaned_avg"
		
		if (centre_transition_repeats == 1)
//			closeallGraphs(); master_ct_clean_average($ct_wavename, 1, 0, "dat")
		else
			avg_wav($ct_wavename)
			duplicate /o $(ct_wavename + "_avg") $(avg_ct_name)
		endif
		
		
		// removing the first data point and re-scalign the x-axis as 'delepoints' does not hold same x-axis
		variable num_points_to_delete = 1
		wave avg_ct_wave = $avg_ct_name
		create_x_wave(avg_ct_wave)
		wave x_wave
		
		variable start_x = x_wave[num_points_to_delete]
		variable num_x = dimsize(avg_ct_wave, 0) - 1
		variable fin_x = x_wave[num_x]
		
		DeletePoints  0, num_points_to_delete, $avg_ct_name
		setscale /I x start_x, fin_x, $avg_ct_name
		
	endfor
	

	///// PROCESS ENTROPY DATA /////
	int num_entropy_dats = ItemsInList(entropy_datnums, ";")
	for (i=0; i<num_entropy_dats; i++)
		master_entropy_clean_average(str2num(stringfromlist(i, entropy_datnums)), 5, num_points_in_entropy, centre_repeats=0, resample_before_centering=400, average_repeats=1, demodulate_on=1, cold_awg_first=1, apply_scaling=0, divide_data=divide_all_data)
	endfor
	
	
	///// RUN GLOBAL FIT /////
	variable cond_chisq, occ_chisq, condocc_chisq
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(global_temps, global_datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_entropy=0, fit_entropy_dats=entropy_datnums)
	
	
	///// SETTING UP GRAAPHS TO PLOT TEMPERATURE DEPENDANCE /////
	Display; KillWindow /Z figure_entropy_occupation; DoWindow/C/O figure_entropy_occupation
//	Display; KillWindow /Z figure_entropy_shift; DoWindow/C/O figure_entropy_shift


	string trans_avg, trans_avg_fit
	string occ_avg, occ_avg_fit
	string entropy_avg, entropy_avg_fit
	string int_entropy_avg, int_entropy_avg_fit
	
	string colour, e_temp
	variable red, green, blue
//	string colours = "0,0,65535;64981,37624,14500;65535,0,0" // three temps
	string colours = "0,0,65535;32768,54615,65535;64981,37624,14500;65535,0,0" // four temps
	
	string legend_text = ""
	variable  datnum
//	for (i=0;i<num_global_datnums;i+=1)
//		datnum = str2num(stringfromlist(i, global_datnums))
	for (i=0;i<1;i+=1)
		datnum = str2num(stringfromlist(i, entropy_datnums))

		e_temp = stringfromlist(i, global_temps)
		
		// defining transition, occupation and entropy, data and fit names
//		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
//		trans_avg_fit = "GFit_" + trans_avg
//		
//		occ_avg = trans_avg + "_occ"
//		occ_avg_fit = "GFit_" + occ_avg
//		
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		trans_avg_fit = "fit_" + trans_avg
		
		occ_avg = trans_avg + "_occ"
		occ_avg_fit = "fit_" + occ_avg
		
		legend_text = legend_text + "\\s(" + trans_avg_fit +  "_figc) " +  e_temp + "mK\r"
		
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		
		//////////////////////////////////////////
		///// ADDING ENTROPY VS SWEEPGATE /////
		//////////////////////////////////////////
		if (i < num_entropy_dats)
			entropy_avg = "dat" + stringfromlist(i, entropy_datnums) + "_numerical_entropy_avg"
			entropy_avg_fit = "fit_" + entropy_avg
			
			string entropy_avg_data_wave_name = entropy_avg + "_figc"
			string entropy_avg_fit_wave_name = entropy_avg_fit + "_figc"
			
			duplicate/o $entropy_avg $entropy_avg_data_wave_name
			duplicate/o $entropy_avg_fit $entropy_avg_fit_wave_name
			
			wave entropy_avg_data_wave = $entropy_avg_data_wave_name 
			wave entropy_avg_fit_wave = $entropy_avg_fit_wave_name 
			
//			smooth 600, $entropy_avg_data_wave_name
			
			SetScale/I x pnt2x(entropy_avg_data_wave, 0)/200, pnt2x(entropy_avg_data_wave, dimsize(entropy_avg_data_wave, 0) - 1)/200, entropy_avg_data_wave // setting scale in real gate units (P*200)
			SetScale/I x pnt2x(entropy_avg_fit_wave, 0)/200, pnt2x(entropy_avg_fit_wave, dimsize(entropy_avg_fit_wave, 0) - 1)/200, entropy_avg_fit_wave  
	//		
			AppendToGraph /W=figure_entropy_occupation  /R, $entropy_avg_data_wave_name;  AppendToGraph /W=figure_entropy_occupation /R, $entropy_avg_fit_wave_name;
			ModifyGraph /W=figure_entropy_occupation  mode($entropy_avg_data_wave_name)=2, lsize($entropy_avg_data_wave_name)=1, rgb($entropy_avg_data_wave_name)=(red,green,blue)
			ModifyGraph /W=figure_entropy_occupation  mode($entropy_avg_fit_wave_name)=0, lsize($entropy_avg_fit_wave_name)=2, rgb($entropy_avg_fit_wave_name)=(red,green,blue)
			
			
			
			////// calculating for integrated entropy dS /////
			int_entropy_avg = entropy_avg + "_int"
			int_entropy_avg_fit = entropy_avg_fit + "_int"
			
			string int_entropy_avg_data_wave_name = int_entropy_avg + "_figc"
			string int_entropy_avg_fit_wave_name = int_entropy_avg_fit + "_figc"
				
			duplicate/o $int_entropy_avg $int_entropy_avg_data_wave_name
			duplicate/o $int_entropy_avg_fit $int_entropy_avg_fit_wave_name
			
			wave int_entropy_avg_data_wave = $int_entropy_avg_data_wave_name 
			wave int_entropy_avg_fit_wave = $int_entropy_avg_fit_wave_name 
			
//			smooth 600, $int_entropy_avg_data_wave_name
			
			SetScale/I x pnt2x(int_entropy_avg_data_wave, 0)/200, pnt2x(int_entropy_avg_data_wave, dimsize(int_entropy_avg_data_wave, 0) - 1)/200, int_entropy_avg_data_wave // setting scale in real gate units (P*200)
			SetScale/I x pnt2x(int_entropy_avg_fit_wave, 0)/200, pnt2x(int_entropy_avg_fit_wave, dimsize(int_entropy_avg_fit_wave, 0) - 1)/200, int_entropy_avg_fit_wave  
		endif
		
		
		//////////////////////////////////////////
		///// ADDING OCCUPATION VS SWEEPGATE /////
		//////////////////////////////////////////
		///// adding occupation /////
		string occ_avg_data_wave_name = occ_avg + "_figc"
		string occ_avg_fit_wave_name = occ_avg_fit + "_figc"
		
		duplicate/o $occ_avg $occ_avg_data_wave_name
		duplicate/o $occ_avg_fit $occ_avg_fit_wave_name
		
		wave occ_avg_data_wave = $occ_avg_data_wave_name 
		wave occ_avg_fit_wave = $occ_avg_fit_wave_name 
		
		SetScale/I x pnt2x(occ_avg_data_wave, 0)/200, pnt2x(occ_avg_data_wave, dimsize(occ_avg_data_wave, 0) - 1)/200, occ_avg_data_wave
		SetScale/I x pnt2x(occ_avg_fit_wave, 0)/200, pnt2x(occ_avg_fit_wave, dimsize(occ_avg_fit_wave, 0) - 1)/200, occ_avg_fit_wave 

		///// Appending traces to graph ca /////
		AppendToGraph /W=figure_entropy_occupation  occ_avg_data_wave; AppendToGraph /W=figure_entropy_occupation  occ_avg_fit_wave;
		ModifyGraph /W=figure_entropy_occupation  mode($occ_avg_data_wave_name)=2, lsize($occ_avg_data_wave_name)=1, rgb($occ_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_entropy_occupation  mode($occ_avg_fit_wave_name)=0, lsize($occ_avg_fit_wave_name)=2, rgb($occ_avg_fit_wave_name)=(red,green,blue)
		
		
	endfor
	
end



function make_figure_entropy_shift([variable baset])
	baset = paramisdefault(baset) ? 22.5 : baset
	
	// first set
//	string low_gamma_datnumn = "1109"
//	string mid_gamma_datnumn = "1111"
//	string high_gamma_datnumn = "1113"
	
//	// second set
//	string low_gamma_datnumn = "1131"
//	string mid_gamma_datnumn = "1133"
//	string high_gamma_datnumn = "1135"

//// third set (faster sampling)
//	string low_gamma_datnumn = "1147"
//	string mid_gamma_datnumn = "1149"
//	string high_gamma_datnumn = "1151"
	
//// fourth set (improved heating)
//	string low_gamma_datnumn = "1233"
//	string mid_gamma_datnumn = "1234"
//	string high_gamma_datnumn = "1235"
	
	// big entropy dataset
//	string entropy_datnums = "1281;1282;1283;1284"
//	string occupation_datnums = "1281;1282;1283;1284"
//	string entropy_couplings = "weak;mid-weak;mid-strong;strong"
//	string entropy_datnums = "1281;1282;1283"
//	string occupation_datnums = "1281;1282;1283"
//	string entropy_couplings = "weak;mid-weak;mid-strong"
//	string legend_axis = "Γ/T"
	
	// varying the CS bias
//	string entropy_datnums = "1372;1284;1373;1374;1439"
//	string occupation_datnums = "1372;1284;1373;1374;1439"
//	string entropy_couplings = "50uV;100uV;250uV;500uV;1000uV"
//	string legend_axis = "CS Bias"
	
	// symmetric vs non symmetric
//	string entropy_datnums = "1372;1473"
//	string occupation_datnums = "1372;1473"
//	string entropy_couplings = "50uV (non sym);50uV (sym)"
//	string legend_axis = "CS Bias"

	// 1st plateau vs 2nd plateau
	string entropy_datnums = "1372;1505"
	string occupation_datnums = "1372;1505"
	string entropy_couplings = "100uV 1st step; 150uV 2nd step"
	string legend_axis = "CS Step"
	

	
//	////// data names /////
	string base_name_data_y = "_numerical_entropy_avg_figc"
	string base_name_data_x = "_cs_cleaned_avg_occ_figc"
	
	string base_name_int_data_y = "_numerical_entropy_avg_int_figc"
	
	////// NRG names /////
	string base_name_fit_y = "_numerical_entropy_avg_figc"
	string base_name_fit_x = "_cs_cleaned_avg_occ_figc"
	
	string base_name_int_fit_y = "_numerical_entropy_avg_int_figc"

	
	string data_y, data_x, fit_y, fit_x, data_y_shift, fit_y_shift, data_y_interp, datnum, marker_size
	string int_data_y, int_data_y_shift, int_data_y_interp, int_fit_y, int_fit_y_shift
	
	closeallGraphs()
	
	Display; KillWindow /Z figure_entropy_shift; DoWindow/C/O figure_entropy_shift
	Display; KillWindow /Z figure_int_entropy_shift; DoWindow/C/O figure_int_entropy_shift

//	Display; KillWindow /Z figure_entropy_occupation; DoWindow/C/O figure_entropy_occupation
	
	string colour, e_temp
	variable red, green, blue
//	string colours = "24158,34695,23901;47802,0,2056;52685,33924,12336;14906,27499,34438" // green, red, yellow, blue
	string colours = "0,0,0;24158,34695,23901;52685,33924,12336;47802,0,2056;14906,27499,34438" // black, green, yellow, red
 	
	int i
	string entropy_datnum, occupation_datnum
	string legend_string = "\r"
	variable num_entropy_datnums = ItemsInList(entropy_datnums, ";")
	variable scale_y_offset, scale_y_multiplier
	for (i=0; i<num_entropy_datnums; i++)
	
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		
		entropy_datnum = stringfromlist(i, entropy_datnums)
		occupation_datnum = stringfromlist(i, occupation_datnums)
		
		
		// dndt wavenames 
		data_y = "dat" + entropy_datnum + base_name_data_y
		data_y_shift = data_y + "_shift"
		data_y_interp = data_y + "_interp"
		data_x = "dat" + occupation_datnum + base_name_data_x
		
		fit_y = "fit_dat" + entropy_datnum + base_name_fit_y
		fit_y_shift = fit_y + "_shift"
		fit_x = "fit_dat" + occupation_datnum + base_name_fit_x
		
		// integrated wavenames
		int_data_y = "dat" + entropy_datnum + base_name_int_data_y
		int_data_y_shift = int_data_y + "_shift"
		int_data_y_interp = int_data_y + "_interp"
//		data_x = "dat" + occupation_datnum + base_name_data_x
		
		int_fit_y = "fit_dat" + entropy_datnum + base_name_int_fit_y
		int_fit_y_shift = int_fit_y + "_shift"
//		fit_x = "fit_dat" + occupation_datnum + base_name_fit_x
		
		marker_size = data_y + "_marker_size"
		
		create_marker_size($data_y, 3, min_marker=0.01, max_marker=2)
		
		////////////////////
		///// figure 1 /////
		////////////////////
		// shift and add data
		duplicate /o $data_y $data_y_shift
//		wavestats /q $data_y_shift
//		scale_y_offset = mean($data_y_shift, pnt2x($data_y_shift, 0), pnt2x($data_y_shift, V_npnts/4))
//		wave dat_y_shift_wave = $data_y_shift
//		dat_y_shift_wave[] = dat_y_shift_wave[p] - scale_y_offset
		
//		scale_y_multiplier = 1/(wavemax($data_y_shift))
		translate_wave_by_occupation($data_y_shift, $data_x) 
		AppendToGraph /W= figure_entropy_shift $data_y_shift; 
		ModifyGraph /W= figure_entropy_shift mode($data_y_shift)=3, marker($data_y_shift)=41, lsize($data_y_shift)=2, zmrkSize($data_y_shift)={$marker_size,*,*,0.01,4}, rgb($data_y_shift)=(red,green,blue)
//		ModifyGraph /W= figure_entropy_shift muloffset($data_y_shift)={0, scale_y_offset}
//		ModifyGraph /W= figure_entropy_shift muloffset($data_y_shift)={0, scale_y_multiplier}
		
		// shift and add fit
		duplicate /o $fit_y $fit_y_shift
		
//		wave fit_y_shift_wave = $fit_y_shift
//		fit_y_shift_wave[] = fit_y_shift_wave[p] - scale_y_offset
		translate_wave_by_occupation($fit_y_shift, $fit_x)
		AppendToGraph /W= figure_entropy_shift $fit_y_shift;
		ModifyGraph /W= figure_entropy_shift mode($fit_y_shift)=0, lsize($fit_y_shift)=2, rgb($fit_y_shift)=(red,green,blue)
//		ModifyGraph /W= figure_entropy_shift muloffset($fit_y_shift)={0, scale_y_offset}
//		ModifyGraph /W= figure_entropy_shift muloffset($fit_y_shift)={0, scale_y_multiplier}
	
	
	
		////////////////////
//		///// figure 2 /////
		////////////////////
////		// append to entropy vs occupation
//		duplicate /o $data_x $data_y_interp
////		wave data_y_interp_wave = $data_y_interp
//		Interpolate2/T=1/E=2/Y=$data_y_interp/I=3 $data_y //linear interpolation // T=1: Linear || E=2: Match 2nd derivative || I=3:gives output at x-coords specified (destination must be created)|| Y=destination wave ||
//
//		AppendToGraph /W= figure_entropy_occupation $data_y_interp vs $data_x; //AppendToGraph /W= figure_entropy_shift /r $data_x 
//		ModifyGraph /W= figure_entropy_occupation mode($data_y_interp)=3, marker($data_y_interp)=41, lsize($data_y_interp)=2, zmrkSize($data_y_interp)={$marker_size,*,*,0.01,4}, rgb($data_y_interp)=(red,green,blue)
////	
//		AppendToGraph /W= figure_entropy_occupation $fit_y vs $fit_x; //AppendToGraph /W= figure_entropy_shift /r $data_x 
//		ModifyGraph /W= figure_entropy_occupation mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(red,green,blue)
		
		
		
		///////////////////////////////
//		///// integrated figure 1 /////
		///////////////////////////////
		// shift and add data
		duplicate /o $int_data_y $int_data_y_shift
//		wavestats /q $int_data_y_shift
//		scale_y_offset = mean($int_data_y_shift, pnt2x($int_data_y_shift, 0), pnt2x($int_data_y_shift, V_npnts/4))
//		wave dat_y_shift_wave = $data_y_shift
//		dat_y_shift_wave[] = dat_y_shift_wave[p] - scale_y_offset
		
//		scale_y_multiplier = 1/(wavemax($data_y_shift))
		translate_wave_by_occupation($int_data_y_shift, $data_x) 
		AppendToGraph /W= figure_int_entropy_shift $int_data_y_shift; 
		ModifyGraph /W= figure_int_entropy_shift mode($int_data_y_shift)=3, marker($int_data_y_shift)=41, lsize($int_data_y_shift)=2, zmrkSize($int_data_y_shift)={$marker_size,*,*,0.01,4}, rgb($int_data_y_shift)=(red,green,blue)
//		ModifyGraph /W= figure_entropy_shift muloffset($data_y_shift)={0, scale_y_offset}
//		ModifyGraph /W= figure_entropy_shift muloffset($data_y_shift)={0, scale_y_multiplier}
		
		// shift and add fit
		duplicate /o $int_fit_y $int_fit_y_shift
		
//		wave int_fit_y_shift_wave = $int_fit_y_shift
//		fit_y_shift_wave[] = fit_y_shift_wave[p] - scale_y_offset
		translate_wave_by_occupation($int_fit_y_shift, $fit_x)
		AppendToGraph /W= figure_int_entropy_shift $int_fit_y_shift;
		ModifyGraph /W= figure_int_entropy_shift mode($int_fit_y_shift)=0, lsize($int_fit_y_shift)=2, rgb($int_fit_y_shift)=(red,green,blue)
//		ModifyGraph /W= figure_entropy_shift muloffset($fit_y_shift)={0, scale_y_offset}
//		ModifyGraph /W= figure_entropy_shift muloffset($fit_y_shift)={0, scale_y_multiplier}
	
		
		
		
		
		legend_string = legend_string + "\\s(dat" + entropy_datnum + "_numerical_entropy_avg_figc_shift) " + legend_axis + " = " + stringfromlist(i, entropy_couplings) + "\r"
	endfor
	
	
	
	closeallGraphs(no_close_graphs="figure_entropy_shift;figure_entropy_occupation")
	
	Legend /W= figure_entropy_shift/C/N=text0/A=RT/X=63.49/Y=5.56/J legend_string
	
	ModifyGraph /W= figure_entropy_shift mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=14, tick=2, gFont="Calibri", gfSize=14 // Mirror unticked


end

//
//function figure_C_separate([variable baset, string gamma_type, variable field_on])
//	baset = paramisdefault(baset) ? 15 : baset
//	gamma_type = selectString(paramisdefault(gamma_type), gamma_type, "high") 
//	field_on = paramisdefault(field_on) ? 0 : field_on
//	
//	string datnums, gamma_over_temp_type
////	if ((StringMatch(gamma_type, "high") == 1) &&  (field_on == 0))
////		datnums = "6079;6088;6085;6082"; gamma_over_temp_type = "high" // high gamma
////	elseif ((StringMatch(gamma_type, "mid") == 1) && (field_on == 0))
////		datnums = "6080;6089;6086;6083"; gamma_over_temp_type = "mid" // mid gamma
////	elseif ((StringMatch(gamma_type, "low") == 1) && (field_on == 0))
////		datnums = "6081;6090;6087;6084"; gamma_over_temp_type = "low" // low gamma
////	elseif ((StringMatch(gamma_type, "high") == 1) && (field_on == 1))
////		datnums = "6100;6097;6094;6091"; gamma_over_temp_type = "high" // high gamma
////	endif
//
//
//	if (StringMatch(gamma_type, "high") == 1)
//		datnums = "699;695;691"; gamma_over_temp_type = "high" // high gamma
//	elseif (StringMatch(gamma_type, "high_mid") == 1)
//		datnums = "698;694;690"; gamma_over_temp_type = "mid" // mid gamma
//	elseif (StringMatch(gamma_type, "low_mid") == 1)
//		datnums = "697;693;689"; gamma_over_temp_type = "mid" // low gamma
//	elseif (StringMatch(gamma_type, "low") == 1)
//		datnums = "696;692;688"; gamma_over_temp_type = "low" // high gamma
//	endif
//	
//
//
//
//	string e_temps = num2str(baset) + ";275;500"
//	string colours = "0,0,65535;64981,37624,14500;65535,0,0"
////	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
//	string colour, e_temp
//	variable red, green, blue
//	
//	variable cond_chisq, occ_chisq, condocc_chisq
//	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type)
//	
//	variable num_dats = ItemsInList(datnums, ";")
//	
//	
//	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
//	Display; KillWindow /Z figure_cb1; DoWindow/C/O figure_cb1
//	Display; KillWindow /Z figure_cb2; DoWindow/C/O figure_cb2
//	Display; KillWindow /Z figure_cc; DoWindow/C/O figure_cc
//
//	string cond_avg, trans_avg, occ_avg, cond_avg_fit, trans_avg_fit, occ_avg_fit
//	
//	variable mid_occupation_x, mid_occupation_y, y_offset_diff, y_offset_setpoint = 0.0
//	variable quadratic_occupation_coef, linear_occupation_coef, amplitude_occupation_coef
//	string occupation_coef_name
//	
//	
//	string legend_text = ""
//	variable i, datnum
//	for (i=0;i<num_dats;i+=1)
//		datnum = str2num(stringfromlist(i, datnums))
//		e_temp = stringfromlist(i, e_temps)
//		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
//		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
//		occ_avg = trans_avg + "_occ"
//		
//		cond_avg_fit = "GFit_" + cond_avg
//		trans_avg_fit = "fit_" + trans_avg
//		occ_avg_fit = "fit_" + occ_avg
//		
//		legend_text = legend_text + "\\s(" + trans_avg_fit +  "_figc) " +  e_temp + "mK\r"
//		
////		///// getting occupation fit coefficients /////
////		occupation_coef_name = "coef_" + trans_avg
////		wave occupation_coef = $occupation_coef_name
////		///// finding mid occupation y point based on N=0.5 in x /////
//////		mid_occupation_x = occupation_coef[2]
//////		wave occupation_wave = $trans_avg
//////		mid_occupation_y = occupation_wave(mid_occupation_x)
////
////		///// finsing mid occupation based on constant y offset in coefs /////
////		mid_occupation_y = occupation_coef[4]
////		
////		///// finsidng difference between trace setpoint and y-offset /////
////		y_offset_diff = mid_occupation_y - y_offset_setpoint
////		
////		linear_occupation_coef = occupation_coef[5]
////		quadratic_occupation_coef = occupation_coef[6]
////		amplitude_occupation_coef = occupation_coef[7]
//		
//		
//		///// getting correct colour for plot /////
//		colour = stringfromlist(i, colours, ";")
//		red = str2num(stringfromlist(0, colour, ","))
//		green = str2num(stringfromlist(1, colour, ","))
//		blue = str2num(stringfromlist(2, colour, ","))
//		
//		
//		
//		//////////////////////////////////////////
//		///// ADDING CONDUCTION VS SWEEPGATE /////
//		//////////////////////////////////////////
//		string cond_avg_data_wave_name = cond_avg + "_figc"
//		string cond_avg_fit_wave_name = cond_avg_fit + "_figc"
//		
//		duplicate/o $cond_avg $cond_avg_data_wave_name
//		duplicate/o $cond_avg_fit $cond_avg_fit_wave_name
//		
//		wave cond_avg_data_wave = $cond_avg_data_wave_name 
//		wave cond_avg_fit_wave = $cond_avg_fit_wave_name 
//		
////		wave cond_avg_temp = $cond_avg
////		wave cond_avg_fit_temp = $cond_avg_fit
//		
//		SetScale/I x pnt2x(cond_avg_data_wave, 0)/200, pnt2x(cond_avg_data_wave, dimsize(cond_avg_data_wave, 0) - 1)/200, cond_avg_data_wave // setting scale in real gate units (P*200)
//		SetScale/I x pnt2x(cond_avg_fit_wave, 0)/200, pnt2x(cond_avg_fit_wave, dimsize(cond_avg_fit_wave, 0) - 1)/200, cond_avg_fit_wave  
//		
//		AppendToGraph /W=figure_ca $cond_avg_data_wave_name; AppendToGraph /W=figure_ca $cond_avg_fit_wave_name;
//		ModifyGraph /W=figure_ca mode($cond_avg_data_wave_name)=2, lsize($cond_avg_data_wave_name)=1, rgb($cond_avg_data_wave_name)=(red,green,blue)
//		ModifyGraph /W=figure_ca mode($cond_avg_fit_wave_name)=0, lsize($cond_avg_fit_wave_name)=2, rgb($cond_avg_fit_wave_name)=(red,green,blue)
//		
//		
//		
//		//////////////////////////////////////////
//		///// ADDING OCCUPATION VS SWEEPGATE /////
//		//////////////////////////////////////////
//		///// adding occupation /////
//		string occ_avg_data_wave_name = occ_avg + "_figc"
//		string occ_avg_fit_wave_name = occ_avg_fit + "_figc"
//		
//		duplicate/o $occ_avg $occ_avg_data_wave_name
//		duplicate/o $occ_avg_fit $occ_avg_fit_wave_name
//		
//		wave occ_avg_data_wave = $occ_avg_data_wave_name 
//		wave occ_avg_fit_wave = $occ_avg_fit_wave_name 
//		
////		wave occ_avg_temp = $occ_avg
////		wave occ_avg_fit_temp = $occ_avg_fit
//		
//		///// METHOD 1 ::::: Re-offsetting and removing quadratic and linear terms /////
////		duplicate/o $trans_avg $trans_avg_data_wave_name
////		duplicate/o $trans_avg tempx
////		tempx = x
////
////		wave trans_avg_data_wave = $trans_avg_data_wave_name
////		trans_avg_data_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
////		trans_avg_data_wave /= amplitude_occupation_coef
////		
////		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
////		duplicate/o $trans_avg_fit tempx
////		tempx = x
////		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
////		trans_avg_fit_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
////		trans_avg_fit_wave /= amplitude_occupation_coef
////
////		///// METHOD 2 ::::: Re-fitting but with offset, linear and quadratic set to 0. /////
////		string new_occupation_coef_name = occupation_coef_name + "_duplicate"
////		duplicate/o $occupation_coef_name $new_occupation_coef_name
////		wave new_occupation_coef = $new_occupation_coef_name
////		
////		new_occupation_coef[4]=0; new_occupation_coef[5]=0; new_occupation_coef[6]=0; new_occupation_coef[7]=1;
////		
////		///// calculating data
////		duplicate/o $trans_avg $trans_avg_data_wave_name
////		duplicate/o $trans_avg tempx
////		tempx = x
////
////		wave trans_avg_data_wave = $trans_avg_data_wave_name
////		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_data_wave, tempx)
////		
////		///// calculating fit
////		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
////		duplicate/o $trans_avg_fit tempx
////		tempx = x
////
////		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
////		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_fit_wave, tempx)
//
//		
//		SetScale/I x pnt2x(occ_avg_data_wave, 0)/200, pnt2x(occ_avg_data_wave, dimsize(occ_avg_data_wave, 0) - 1)/200, occ_avg_data_wave
//		SetScale/I x pnt2x(occ_avg_fit_wave, 0)/200, pnt2x(occ_avg_fit_wave, dimsize(occ_avg_fit_wave, 0) - 1)/200, occ_avg_fit_wave 
//		
//
//		///// Appending traces to graph ca /////
//		AppendToGraph /W=figure_cb1 occ_avg_data_wave; AppendToGraph /W=figure_cb1 occ_avg_fit_wave;
//		ModifyGraph /W=figure_cb1 mode($occ_avg_data_wave_name)=2, lsize($occ_avg_data_wave_name)=1, rgb($occ_avg_data_wave_name)=(red,green,blue)
//		ModifyGraph /W=figure_cb1 mode($occ_avg_fit_wave_name)=0, lsize($occ_avg_fit_wave_name)=2, rgb($occ_avg_fit_wave_name)=(red,green,blue)
//		
//		
//		
//		
//		///// adding charghe transition /////
//		string trans_avg_data_wave_name = trans_avg + "_figc"
//		string trans_avg_fit_wave_name = trans_avg_fit + "_figc"
//		
//		duplicate/o $trans_avg $trans_avg_data_wave_name
//		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
//		
//		wave trans_avg_data_wave = $trans_avg_data_wave_name 
//		wave trans_avg_fit_wave = $trans_avg_fit_wave_name 
//		
////		wave trans_avg_temp = $trans_avg
////		wave trans_avg_fit_temp = $trans_avg_fit
//		
//		SetScale/I x pnt2x(trans_avg_data_wave, 0)/200, pnt2x(trans_avg_data_wave, dimsize(trans_avg_data_wave, 0) - 1)/200, trans_avg_data_wave
//		SetScale/I x pnt2x(trans_avg_fit_wave, 0)/200, pnt2x(trans_avg_fit_wave, dimsize(trans_avg_fit_wave, 0) - 1)/200, trans_avg_fit_wave 
//		
//		///// Appending traces to graph cb /////
//		AppendToGraph /W=figure_cb2 $trans_avg_data_wave_name; AppendToGraph /W=figure_cb2 $trans_avg_fit_wave_name;
//		ModifyGraph /W=figure_cb2 mode($trans_avg_data_wave_name)=2, lsize($trans_avg_data_wave_name)=1, rgb($trans_avg_data_wave_name)=(red,green,blue)
//		ModifyGraph /W=figure_cb2 mode($trans_avg_fit_wave_name)=0, lsize($trans_avg_fit_wave_name)=2, rgb($trans_avg_fit_wave_name)=(red,green,blue)
//		
//		
////		///////////////////////////////////////////
////		///// ADDING CONDUCTION VS OCCUPATION /////
////		///////////////////////////////////////////
//////		string cond_vs_occ_data_wave_name_y = cond_avg + "_cond_data"
//////		string cond_vs_occ_data_wave_name_x = cond_avg + "_occ_nrg"
////		string cond_vs_occ_data_wave_name_y = cond_avg
////		string cond_vs_occ_data_wave_name_x = cond_avg + "_occ_nrg"
////		
//////		///// START EXTRA /////
////		duplicate /o trans_avg_data_wave $cond_vs_occ_data_wave_name_x
////		SetScale/I x pnt2x($cond_vs_occ_data_wave_name_y, 0)/200, pnt2x($cond_vs_occ_data_wave_name_y, dimsize($cond_vs_occ_data_wave_name_y, 0) - 1)/200, $cond_vs_occ_data_wave_name_y
//////		crop_waves_by_x_scaling($cond_vs_occ_data_wave_name_y, $cond_vs_occ_data_wave_name_x)
//////		///// END EXTRA /////
////		
////		AppendToGraph /W=figure_cc $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x;
////		ModifyGraph /W=figure_cc mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
////		
////		string cond_vs_occ_fit_wave_name_y = cond_avg + "_cond_nrg"
////		string cond_vs_occ_fit_wave_name_x = cond_avg + "_occ_nrg"
////		AppendToGraph /W=figure_cc $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
////		ModifyGraph /W=figure_cc mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(red,green,blue)
//		
//	endfor
//	
//	// tick scales https://www.wavemetrics.com/forum/general/about-axis-scale
//	
//	///// setting  axis labels /////
//	// y - axis labels
////	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
////	Label /W=figure_cb1 left "Occupation (.arb)"
////	Label /W=figure_cb2 left "Current (nA)"
////	Label /W=figure_cc left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
//	
//	// x - axis labels
////	Label /W=figure_ca bottom "Sweep Gate (mV)"
////	Label /W=figure_cb1 bottom "Sweep Gate (mV)"
////	Label /W=figure_cb2 bottom "Sweep Gate (mV)"
////	Label /W=figure_cc bottom "Occupation (.arb)"
//	
//	// setting axis range
//	SetAxis /W=figure_ca bottom -10, 10
//	SetAxis /W=figure_cb1 bottom -20, 20
//	SetAxis /W=figure_cb2 bottom -20, 20
//	
//	
////	///// off-setting labels from the axis /////
////	ModifyGraph /W=figure_ca lblPos(l2)=90
////	ModifyGraph /W=figure_ca lblPos(l3)=90
////	ModifyGraph /W=figure_ca lblPos(left)=90
////	ModifyGraph /W=figure_ca lblPos(bottom)=80
////	ModifyGraph /W=figure_ca lblPos(b3)=80
//	
//	
//	///// adding legend /////
////	Legend/W=figure_ca/C/N=legend_figc/J/A=LT legend_text
//	Legend/W=figure_cb1/C/N=legend_figc/J/A=LT legend_text
////	Legend/W=figure_cb2/C/N=legend_figc/J/A=LT legend_text
////	Legend/W=figure_cc/C/N=legend_figc/J/A=LT legend_text
////	print legend_text
//end


function figure_B_NRG()
	// SavePICT/P=home/E=-5/RES=1000/o
	// assumes NRG waves g_nrg and occ_nrg have been created
	// assumes
	// black (0,0,0)
	// green (94,135,93)
	// yellow (205,132,48)
	// red (186,0,8)
	
	// creating x and y g_wave
	wave g_nrg
	create_x_wave(g_nrg)
	wave x_wave
//	duplicate /o x_wave g_nrg_x
	
	create_y_wave(g_nrg)
	wave y_wave
	duplicate /o y_wave g_nrg_y
	
	wave g_nrg_y
	duplicate /o g_nrg_y gammas
	wave gammas
	gammas = exp(g_nrg_y)
	
	
//	// creating x and y g_wave
	wave occ_nrg
	
	

	make /o /N=4 gamma_over_t_wave = {0.1, 1, 5, 20}
	variable gamma_over_t
	int gamma_index
	variable mu_centre_index
	
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) g_nrg_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) occ_nrg_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) mu_nrg_align_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) mu_nrg_unalign_pick
	make /o /N=(dimsize(x_wave, 0)) occ_nrg_1d_dummy_pick
	
	
	int i
	for (i=0; i<4; i++)
	
		gamma_over_t = gamma_over_t_wave[i]
		
		FindLevel /Q /P gammas, gamma_over_t
		gamma_index = V_LevelX
		
		g_nrg_pick[][i] = g_nrg[p][gamma_index]
		occ_nrg_pick[][i] = occ_nrg[p][gamma_index]
		
		occ_nrg_1d_dummy_pick[] = occ_nrg[p][gamma_index]
	
	
		FindLevel /Q /P occ_nrg_1d_dummy_pick, 0.5
		mu_centre_index = V_LevelX
		
		mu_nrg_align_pick[][i] = (x_wave[p] - x_wave[mu_centre_index]) * gamma_over_t_wave[i] / 1E-4
		mu_nrg_unalign_pick[][i] = (x_wave[p]) * gamma_over_t_wave[i] / 1E-4
		
	endfor
	
	// rescale x axis (it's somewhat arbitrary anyway) //
	mu_nrg_unalign_pick[][0] = mu_nrg_unalign_pick[p][0] / 1e3
	mu_nrg_unalign_pick[][1] = mu_nrg_unalign_pick[p][1] / 1e3
	mu_nrg_unalign_pick[][2] = mu_nrg_unalign_pick[p][2] / 1e3
	mu_nrg_unalign_pick[][3] = mu_nrg_unalign_pick[p][3] / 1e3
	
	mu_nrg_align_pick[][0] = mu_nrg_align_pick[p][0] / 1e3
	mu_nrg_align_pick[][1] = mu_nrg_align_pick[p][1] / 1e3
	mu_nrg_align_pick[][2] = mu_nrg_align_pick[p][2] / 1e3
	mu_nrg_align_pick[][3] = mu_nrg_align_pick[p][3] / 1e3
	
	// make windows
	Display; KillWindow /Z figure_nrg_g_unaligned; DoWindow/C/O figure_nrg_g_unaligned 
	Display; KillWindow /Z figure_nrg_occ_unaligned; DoWindow/C/O figure_nrg_occ_unaligned 
	
	Display; KillWindow /Z figure_nrg_g_aligned; DoWindow/C/O figure_nrg_g_aligned 
	Display; KillWindow /Z figure_nrg_occ_aligned; DoWindow/C/O figure_nrg_occ_aligned 
	
	
	
	///////////////////////////////////////////////////////
	///////////////// unaligned g /////////////////////////
	///////////////////////////////////////////////////////
	AppendToGraph /W=figure_nrg_g_unaligned g_nrg_pick[][0] vs mu_nrg_unalign_pick[][0]
	AppendToGraph /W=figure_nrg_g_unaligned g_nrg_pick[][1] vs mu_nrg_unalign_pick[][1]
	AppendToGraph /W=figure_nrg_g_unaligned g_nrg_pick[][2] vs mu_nrg_unalign_pick[][2]
	AppendToGraph /W=figure_nrg_g_unaligned g_nrg_pick[][3] vs mu_nrg_unalign_pick[][3]
	
	ModifyGraph /W=figure_nrg_g_unaligned lsize(g_nrg_pick)=2, rgb(g_nrg_pick)=(0,0,0)
	ModifyGraph /W=figure_nrg_g_unaligned lsize(g_nrg_pick#1)=2, rgb(g_nrg_pick#1)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_nrg_g_unaligned lsize(g_nrg_pick#2)=2, rgb(g_nrg_pick#2)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_nrg_g_unaligned lsize(g_nrg_pick#3)=2, rgb(g_nrg_pick#3)=(186*257,0*257,8*257)
	
//	Label /W=figure_nrg_g_unaligned bottom "Energy (arb.)"
//	Label /W=figure_nrg_g_unaligned left "Conductance (\\$WMTEX$ 2e^2/h \\$/WMTEX$)"
	SetAxis /W=figure_nrg_g_unaligned bottom -1.2e+03,1.2e+03
	ModifyGraph /W=figure_nrg_g_unaligned mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14

	
	
	///////////////////////////////////////////////////////
	////////////////////// unaligned occ //////////////////
	///////////////////////////////////////////////////////
	AppendToGraph /W=figure_nrg_occ_unaligned occ_nrg_pick[][0] vs mu_nrg_unalign_pick[][0]
	AppendToGraph /W=figure_nrg_occ_unaligned occ_nrg_pick[][1] vs mu_nrg_unalign_pick[][1]
	AppendToGraph /W=figure_nrg_occ_unaligned occ_nrg_pick[][2] vs mu_nrg_unalign_pick[][2]
	AppendToGraph /W=figure_nrg_occ_unaligned occ_nrg_pick[][3] vs mu_nrg_unalign_pick[][3]
	
	ModifyGraph /W=figure_nrg_occ_unaligned lsize(occ_nrg_pick)=2, rgb(occ_nrg_pick)=(0,0,0)
	ModifyGraph /W=figure_nrg_occ_unaligned lsize(occ_nrg_pick#1)=2, rgb(occ_nrg_pick#1)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_nrg_occ_unaligned lsize(occ_nrg_pick#2)=2, rgb(occ_nrg_pick#2)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_nrg_occ_unaligned lsize(occ_nrg_pick#3)=2, rgb(occ_nrg_pick#3)=(186*257,0*257,8*257)
	
//	Label /W=figure_nrg_occ_unaligned bottom "Energy (arb.)"
//	Label /W=figure_nrg_occ_unaligned left "Occupation"
	SetAxis /W=figure_nrg_occ_unaligned bottom -1.2e+03,1.2e+03
	ModifyGraph /W=figure_nrg_occ_unaligned mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14

	///////////////////////////////////////////////////////
	///////////////// aligned g ///////////////////////////
	///////////////////////////////////////////////////////
	AppendToGraph /W=figure_nrg_g_aligned g_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	AppendToGraph /W=figure_nrg_g_aligned g_nrg_pick[][1] vs mu_nrg_align_pick[][1]
	AppendToGraph /W=figure_nrg_g_aligned g_nrg_pick[][2] vs mu_nrg_align_pick[][2]
	AppendToGraph /W=figure_nrg_g_aligned g_nrg_pick[][3] vs mu_nrg_align_pick[][3]
	
	ModifyGraph /W=figure_nrg_g_aligned lsize(g_nrg_pick)=2, rgb(g_nrg_pick)=(0,0,0)
	ModifyGraph /W=figure_nrg_g_aligned lsize(g_nrg_pick#1)=2, rgb(g_nrg_pick#1)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_nrg_g_aligned lsize(g_nrg_pick#2)=2, rgb(g_nrg_pick#2)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_nrg_g_aligned lsize(g_nrg_pick#3)=2, rgb(g_nrg_pick#3)=(186*257,0*257,8*257)
	
//	Label /W=figure_nrg_g_aligned bottom "Energy (arb.)"
//	Label /W=figure_nrg_g_aligned left "Conductance (\\$WMTEX$ 2e^2/h \\$/WMTEX$)"
	SetAxis /W=figure_nrg_g_aligned bottom -1.2e+03,1.2e+03
	ModifyGraph /W=figure_nrg_g_aligned mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	
	
	///////////////////////////////////////////////////////
	////////////////////// aligned occ ////////////////////
	///////////////////////////////////////////////////////
	AppendToGraph /W=figure_nrg_occ_aligned occ_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	AppendToGraph /W=figure_nrg_occ_aligned occ_nrg_pick[][1] vs mu_nrg_align_pick[][1]
	AppendToGraph /W=figure_nrg_occ_aligned occ_nrg_pick[][2] vs mu_nrg_align_pick[][2]
	AppendToGraph /W=figure_nrg_occ_aligned occ_nrg_pick[][3] vs mu_nrg_align_pick[][3]
	
	ModifyGraph /W=figure_nrg_occ_aligned lsize(occ_nrg_pick)=2, rgb(occ_nrg_pick)=(0,0,0)
	ModifyGraph /W=figure_nrg_occ_aligned lsize(occ_nrg_pick#1)=2, rgb(occ_nrg_pick#1)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_nrg_occ_aligned lsize(occ_nrg_pick#2)=2, rgb(occ_nrg_pick#2)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_nrg_occ_aligned lsize(occ_nrg_pick#3)=2, rgb(occ_nrg_pick#3)=(186*257,0*257,8*257)

	Legend/C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 20"
	
//	Label /W=figure_nrg_occ_aligned bottom "Energy (arb.)"
//	Label /W=figure_nrg_occ_aligned left "Occupation"
	SetAxis /W=figure_nrg_occ_aligned bottom -1.2e+03,1.2e+03
	ModifyGraph /W=figure_nrg_occ_aligned mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=14, tick=2, gFont="Calibri", gfSize=14, gfSize=14
	
//	Legend/C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 20"

	/////	KILL WAVES	/////
	killwaves /Z x_wave
	killwaves /Z y_wave
	killwaves /Z occ_nrg_x
	killwaves /Z occ_nrg_y
	killwaves /Z g_nrg_x
	killwaves /Z g_nrg_y
	killwaves /Z gamma_over_t_wave
	killwaves /Z occ_nrg_1d_dummy_pick
end



function figure_dummy_conductance_occupation()
	// SavePICT/P=home/E=-5/RES=1000/o
	// assumes NRG waves g_nrg and occ_nrg have been created
	// assumes
	// black (0,0,0)
	// green (94,135,93)
	// yellow (205,132,48)
	// red (186,0,8)
	
	// creating x and y g_wave
	wave g_nrg
	create_x_wave(g_nrg)
	wave x_wave
//	duplicate /o x_wave g_nrg_x
	
	create_y_wave(g_nrg)
	wave y_wave
	duplicate /o y_wave g_nrg_y
	
	wave g_nrg_y
	duplicate /o g_nrg_y gammas
	wave gammas
	gammas = exp(g_nrg_y)
	
	
//	// creating x and y g_wave
	wave occ_nrg

	make /o /N=1 gamma_over_t_wave = {0.1}
	variable gamma_over_t
	int gamma_index
	variable mu_centre_index
	
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) g_nrg_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) occ_nrg_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) mu_nrg_align_pick
	make /o /N=(dimsize(x_wave, 0), dimsize(gamma_over_t_wave, 0)) mu_nrg_unalign_pick
	make /o /N=(dimsize(x_wave, 0)) occ_nrg_1d_dummy_pick
	
	
	int i = 0

	gamma_over_t = gamma_over_t_wave[i]
	
	FindLevel /Q /P gammas, gamma_over_t
	gamma_index = V_LevelX
	
	g_nrg_pick[][i] = g_nrg[p][gamma_index]
	occ_nrg_pick[][i] = occ_nrg[p][gamma_index]
	
	occ_nrg_1d_dummy_pick[] = occ_nrg[p][gamma_index]


	FindLevel /Q /P occ_nrg_1d_dummy_pick, 0.5
	mu_centre_index = V_LevelX
	
	mu_nrg_align_pick[][i] = (x_wave[p] - x_wave[mu_centre_index]) * gamma_over_t_wave[i] / 1E-4
	mu_nrg_unalign_pick[][i] = (x_wave[p]) * gamma_over_t_wave[i] / 1E-4
	

	
	// make windows
	Display; KillWindow /Z figure_nrg_g_dummy; DoWindow/C/O figure_nrg_g_dummy
	Display; KillWindow /Z figure_nrg_occ_dummy; DoWindow/C/O figure_nrg_occ_dummy
	Display; KillWindow /Z figure_nrg_combined_dummy; DoWindow/C/O figure_nrg_combined_dummy
	
	///////////////////////////////////////////////////////
	///////////////// aligned g ///////////////////////////
	///////////////////////////////////////////////////////
	mu_nrg_align_pick[][0] = mu_nrg_align_pick[p][0] / 1e3
	AppendToGraph /W=figure_nrg_g_dummy g_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	
//	Label /W=figure_nrg_g_dummy bottom "Energy (arb.)"
//	Label /W=figure_nrg_g_dummy left "Conductance (\\$WMTEX$ 2e^2 / ℏ \\$/WMTEX$)"
	SetAxis /W=figure_nrg_g_dummy bottom -0.1e+03,0.1e+03
	ModifyGraph /W=figure_nrg_g_dummy lsize(g_nrg_pick)=2, rgb(g_nrg_pick)=(0,0,0), mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2,  gFont="Calibri", gfSize=14

	
	
	///////////////////////////////////////////////////////
	////////////////////// aligned occ ////////////////////
	///////////////////////////////////////////////////////
	AppendToGraph /W=figure_nrg_occ_dummy occ_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	
//	Label /W=figure_nrg_occ_dummy bottom "Energy (arb.)\\Z24"
//	Label /W=figure_nrg_occ_dummy left "Occupation\\Z24"
	SetAxis /W=figure_nrg_occ_dummy bottom -0.1e+03,0.1e+03
	ModifyGraph /W=figure_nrg_occ_dummy lsize(occ_nrg_pick)=2, rgb(occ_nrg_pick)=(0,0,0), mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2,  gFont="Calibri", gfSize=14

//	Legend/C/N=text0/J "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 7"


	///////////////////////////////////////////////////////
	////////////////////// combined figure ////////////////
	///////////////////////////////////////////////////////
	// adding to combined
	AppendToGraph /W=figure_nrg_combined_dummy /l=l2 occ_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	// adding to combined
	AppendToGraph /W=figure_nrg_combined_dummy g_nrg_pick[][0] vs mu_nrg_align_pick[][0]
	ModifyGraph /W=figure_nrg_combined_dummy lsize(g_nrg_pick)=2, rgb(g_nrg_pick)=(0,0,0), mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2,  gFont="Calibri", gfSize=14

	SetAxis /W=figure_nrg_combined_dummy bottom -0.1e+03,0.1e+03
	SetAxis /W=figure_nrg_combined_dummy l2 0,1
	ModifyGraph /W=figure_nrg_combined_dummy freePos(l2)={inf,bottom}, tick(l2)=0,tlOffset(l2)=-24,tickEnab(l2)={0,1}
	ModifyGraph /W=figure_nrg_combined_dummy mode(occ_nrg_pick)=7, lsize(occ_nrg_pick)=0.1, rgb(occ_nrg_pick)=(0,0,0), usePlusRGB(occ_nrg_pick)=1, hbFill(occ_nrg_pick)=5, plusRGB(occ_nrg_pick)=(0,0,0, 30000)

//	ModifyGraph /W=figure_nrg_combined_dummy lsize(occ_nrg_pick)=2, rgb(occ_nrg_pick)=(0,0,0)
	
	ModifyGraph /W=figure_nrg_combined_dummy mirror=0, nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph /W=figure_nrg_combined_dummy mirror(bottom)=1
	ModifyGraph /W=figure_nrg_combined_dummy tick(l2)=0
end


function figure_tim_gamma()	
	// SavePICT/P=home/E=-5/RES=1000/o
	// int_entropy_weak, int_entropy_similar, int_entropy_med, int_entropy_strong
	// int_entropy_weak_fit, int_entropy_similar_fit, int_entropy_med_fit, int_entropy_strong_fit
	
	// occupation_data_weak, occupation_data_similar, occupation_data_med, occupation_data_strong
	// occupation_nrg_weak, occupation_nrg_similar, occupation_nrg_med, occupation_nrg_strong
	
	wave int_entropy_weak, int_entropy_similar, int_entropy_med, int_entropy_strong
	wave int_entropy_weak_fit, int_entropy_similar_fit, int_entropy_med_fit, int_entropy_strong_fit
	
	wave occupation_data_weak, occupation_data_similar, occupation_data_med, occupation_data_strong
	wave occupation_nrg_weak, occupation_nrg_similar, occupation_nrg_med, occupation_nrg_strong
	
	// one time re-scaling to get NRG in terms of real gate units
//	SetScale/I x pnt2x(occupation_nrg_weak, 0)/100, pnt2x(occupation_nrg_weak, dimsize(occupation_nrg_weak, 0) - 1)/100, occupation_nrg_weak 
//	SetScale/I x pnt2x(occupation_nrg_similar, 0)/100, pnt2x(occupation_nrg_similar, dimsize(occupation_nrg_similar, 0) - 1)/100, occupation_nrg_similar 
//	SetScale/I x pnt2x(occupation_nrg_med, 0)/100, pnt2x(occupation_nrg_med, dimsize(occupation_nrg_med, 0) - 1)/100, occupation_nrg_med 
//	SetScale/I x pnt2x(occupation_nrg_strong, 0)/100, pnt2x(occupation_nrg_strong, dimsize(occupation_nrg_strong, 0) - 1)/100, occupation_nrg_strong 
//	
//	
	// make windows
	Display; KillWindow /Z figure_poster_gamma_entropy; DoWindow/C/O figure_poster_gamma_entropy 
	Display; KillWindow /Z figure_poster_gamma_occ; DoWindow/C/O figure_poster_gamma_occ 
	
	
	///////////////////////////////////////////////////////
	///////////////// occupation /////////////////////////
	///////////////////////////////////////////////////////
	///// DATA ///// 
	AppendToGraph /W=figure_poster_gamma_occ occupation_data_weak
	AppendToGraph /W=figure_poster_gamma_occ occupation_data_similar
	AppendToGraph /W=figure_poster_gamma_occ occupation_data_med
	AppendToGraph /W=figure_poster_gamma_occ occupation_data_strong
	
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_data_weak)=3, marker(occupation_data_weak)=41, lsize(occupation_data_weak)=2, rgb(occupation_data_weak)=(0,0,0)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_data_similar)=3, marker(occupation_data_similar)=41, lsize(occupation_data_similar)=2, rgb(occupation_data_similar)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_data_med)=3, marker(occupation_data_med)=41, lsize(occupation_data_med)=2, rgb(occupation_data_med)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_data_strong)=3, marker(occupation_data_strong)=41, lsize(occupation_data_strong)=2, rgb(occupation_data_strong)=(186*257,0*257,8*257)
	
	
	///// NRG /////
	AppendToGraph /W=figure_poster_gamma_occ occupation_nrg_weak
	AppendToGraph /W=figure_poster_gamma_occ occupation_nrg_similar
	AppendToGraph /W=figure_poster_gamma_occ occupation_nrg_med
	AppendToGraph /W=figure_poster_gamma_occ occupation_nrg_strong
	
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_nrg_weak)=0, lsize(occupation_nrg_weak)=2, rgb(occupation_nrg_weak)=(0,0,0)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_nrg_similar)=0, lsize(occupation_nrg_similar)=2, rgb(occupation_nrg_similar)=(94*257,135*257,93*257)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_nrg_med)=0, lsize(occupation_nrg_med)=2, rgb(occupation_nrg_med)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_poster_gamma_occ mode(occupation_nrg_strong)=0, lsize(occupation_nrg_strong)=2, rgb(occupation_nrg_strong)=(186*257,0*257,8*257)
	
//	Label /W=figure_poster_gamma_occ bottom "Sweep Gate (mV)\\u#2"
//	Label /W=figure_poster_gamma_occ left "Occupation \\u#2"
	SetAxis /W=figure_poster_gamma_occ bottom -3,3
	ModifyGraph /W=figure_poster_gamma_occ mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	
	///////////////////////////////////////////////////////
	//////////////////// entropy //////////////////////////
	///////////////////////////////////////////////////////
	///// DATA ///// 
	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_weak
//	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_similar
//	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_med
	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_strong
	
	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_weak)=3, marker(int_entropy_weak)=41, lsize(int_entropy_weak)=2, rgb(int_entropy_weak)=(186*257,0,8*257) //rgb(int_entropy_weak)=(0,0,0)
//	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_similar)=3, marker(int_entropy_similar)=41, lsize(int_entropy_similar)=2, rgb(int_entropy_similar)=(94*257,135*257,93*257)
//	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_med)=3, marker(int_entropy_med)=41, lsize(int_entropy_med)=2, rgb(int_entropy_med)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_strong)=3, marker(int_entropy_strong)=41, lsize(int_entropy_strong)=2, rgb(int_entropy_strong)=(58*257,107*257,134*257) //rgb(int_entropy_strong)=(186*257,0*257,8*257)
	
	
	///// NRG /////
	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_weak_fit
//	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_similar_fit
//	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_med_fit
	AppendToGraph /W=figure_poster_gamma_entropy int_entropy_strong_fit
	
	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_weak_fit)=0, lsize(int_entropy_weak_fit)=2, rgb(int_entropy_weak_fit)=(186*257,0,8*257) //rgb(int_entropy_weak_fit)=(0,0,0)
//	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_similar_fit)=0, lsize(int_entropy_similar_fit)=2, rgb(int_entropy_similar_fit)=(94*257,135*257,93*257)
//	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_med_fit)=0, lsize(int_entropy_med_fit)=2, rgb(int_entropy_med_fit)=(205*257,132*257,48*257)
	ModifyGraph /W=figure_poster_gamma_entropy mode(int_entropy_strong_fit)=0, lsize(int_entropy_strong_fit)=2, rgb(int_entropy_strong_fit)=(58*257,107*257,134*257) //rgb(int_entropy_strong_fit)=(186*257,0*257,8*257)
	
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_similar_fit)  Γ/T = 1.3\r\\s(int_entropy_med_fit)  Γ/T = 5\r\\s(int_entropy_strong_fit) Γ/T = 18"
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_strong_fit) Γ/T = 18"
	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit) Γ/T = weak\r\\s(int_entropy_strong_fit) Γ/T = strong"


//	Label /W=figure_poster_gamma_entropy bottom "Sweep Gate (mV)\\u#2"
//	Label /W=figure_poster_gamma_entropy left "Entropy (kB)\\u#2"
	SetAxis /W=figure_poster_gamma_entropy bottom -3,3
	Label /W=figure_poster_gamma_entropy bottom "\\u#2"
	Label /W=figure_poster_gamma_entropy left "\\u#2"
	ModifyGraph /W=figure_poster_gamma_entropy mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14

end



function figure_tim_single()	
	// SavePICT/P=home/E=-5/RES=1000/o
	// int_entropy_weak, int_entropy_similar, int_entropy_med, int_entropy_strong
	// int_entropy_weak_fit, int_entropy_similar_fit, int_entropy_med_fit, int_entropy_strong_fit
	
	// occupation_data_weak, occupation_data_similar, occupation_data_med, occupation_data_strong
	// occupation_nrg_weak, occupation_nrg_similar, occupation_nrg_med, occupation_nrg_strong
	
	wave int_entropy_weak, int_entropy_med
	wave int_entropy_weak_fit, int_entropy_med_fit
	
	wave occupation_data_weak, occupation_data_med
	wave occupation_nrg_weak, occupation_nrg_med
	

	// make windows
	Display; KillWindow /Z figure_poster_gamma_med; DoWindow/C/O figure_poster_gamma_med 
	Display; KillWindow /Z figure_poster_gamma_weak; DoWindow/C/O figure_poster_gamma_weak 
	
	make /o/n=2 ln2 = {ln(2), ln(2)}
	make /o/n=2 ln3 = {ln(3), ln(3)}
	make /o/n=2 ln_xarray = {-2, 2}
	
	///////////////////////////////////////////////////////
	///////////////// med gamma ////////////////////////
	///////////////////////////////////////////////////////	
	///// NRG /////
	AppendToGraph /W=figure_poster_gamma_med /l=l2 occupation_nrg_med
	AppendToGraph /W=figure_poster_gamma_med int_entropy_med_fit
	AppendToGraph /W=figure_poster_gamma_med ln2 vs ln_xarray
	AppendToGraph /W=figure_poster_gamma_med ln3 vs ln_xarray
	
	ModifyGraph /W=figure_poster_gamma_med mode(int_entropy_med_fit)=0, lsize(int_entropy_med_fit)=2, rgb(int_entropy_med_fit)=(0,0,0)
	ModifyGraph /W=figure_poster_gamma_med mode(occupation_nrg_med)=7, lsize(occupation_nrg_med)=0.1, rgb(occupation_nrg_med)=(0,0,0), usePlusRGB(occupation_nrg_med)=1, hbFill(occupation_nrg_med)=5, plusRGB(occupation_nrg_med)=(0,0,0, 30000)

	SetAxis /W=figure_poster_gamma_med bottom -2, 2
	SetAxis /W=figure_poster_gamma_med left 0,1.15
	SetAxis /W=figure_poster_gamma_med l2 0,1
	ModifyGraph /W=figure_poster_gamma_med freePos(l2)={inf,bottom}, tick(l2)=0,tlOffset(l2)=-24,tickEnab(l2)={0,1}
	ModifyGraph /W=figure_poster_gamma_med lstyle(ln2)=11,rgb(ln2)=(0,0,0), lstyle(ln3)=11,rgb(ln3)=(0,0,0)

	Label /W=figure_poster_gamma_med bottom "\\u#2"
	Label /W=figure_poster_gamma_med left "\\u#2"
	Label /W=figure_poster_gamma_med l2 "\\u#2"
	
	ModifyGraph /W=figure_poster_gamma_med mirror=0, nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph /W=figure_poster_gamma_med mirror(bottom)=1
	ModifyGraph /W=figure_poster_gamma_med tick(l2)=0
	
	///////////////////////////////////////////////////////
	//////////////////// weak gamma  //////////////////////
	///////////////////////////////////////////////////////
	///// NRG /////
	AppendToGraph /W=figure_poster_gamma_weak /l=l2 occupation_nrg_weak
	AppendToGraph /W=figure_poster_gamma_weak int_entropy_weak_fit
	AppendToGraph /W=figure_poster_gamma_weak ln2 vs ln_xarray
	AppendToGraph /W=figure_poster_gamma_weak ln3 vs ln_xarray
	
	ModifyGraph /W=figure_poster_gamma_weak mode(int_entropy_weak_fit)=0, lsize(int_entropy_weak_fit)=2, rgb(int_entropy_weak_fit)=(0,0,0)
	ModifyGraph /W=figure_poster_gamma_weak mode(occupation_nrg_weak)=7, lsize(occupation_nrg_weak)=0.1, rgb(occupation_nrg_weak)=(0,0,0), usePlusRGB(occupation_nrg_weak)=1, hbFill(occupation_nrg_weak)=5, plusRGB(occupation_nrg_weak)=(0,0,0, 30000)
	

	SetAxis /W=figure_poster_gamma_weak bottom -2, 2
	SetAxis /W=figure_poster_gamma_weak left 0,1.15
	SetAxis /W=figure_poster_gamma_weak l2 0,1
	ModifyGraph /W=figure_poster_gamma_weak freePos(l2)={inf,bottom}, tick(l2)=0,tlOffset(l2)=-24,tickEnab(l2)={0,1}
	ModifyGraph /W=figure_poster_gamma_weak lstyle(ln2)=11,rgb(ln2)=(0,0,0), lstyle(ln3)=11,rgb(ln3)=(0,0,0)

	Label /W=figure_poster_gamma_weak bottom "\\u#2"
	Label /W=figure_poster_gamma_weak left "\\u#2"
	Label /W=figure_poster_gamma_weak l2 "\\u#2"
	
	ModifyGraph /W=figure_poster_gamma_weak mirror=0, nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph /W=figure_poster_gamma_weak mirror(bottom)=1
	ModifyGraph /W=figure_poster_gamma_weak tick(l2)=0
	
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_similar_fit)  Γ/T = 1.3\r\\s(int_entropy_med_fit)  Γ/T = 5\r\\s(int_entropy_strong_fit) Γ/T = 18"
////	Label /W=figure_poster_gamma_entropy bottom "Sweep Gate (mV)\\u#2"
////	Label /W=figure_poster_gamma_entropy left "Entropy (kB)\\u#2"
//	SetAxis /W=figure_poster_gamma_entropy bottom -3,3
//	Label /W=figure_poster_gamma_entropy bottom "\\u#2"
//	Label /W=figure_poster_gamma_entropy left "\\u#2"
//	ModifyGraph /W=figure_poster_gamma_entropy mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14

end