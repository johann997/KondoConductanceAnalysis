#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>

//
//
//function figure_C()
//	string datnums = "6079;6088;6085;6082" // high gamma
////	string datnums = "6080;6089;6086;6083" // mid gamma
////	string datnums = "6081;6090;6087;6084" // low gamma
//	string e_temps = "23;100;300;500"
//	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
//	string colour, e_temp
//	variable red, green, blue
//	
//	run_clean_average_procedure(datnums=datnums)
//	run_global_fit(15, datnums)
////	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
//	
//	variable num_dats = ItemsInList(datnums, ";")
//	
//	
//	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
////	Display; KillWindow /Z figure_cb; DoWindow/C/O figure_cb
//
//	string cond_avg, trans_avg, cond_avg_fit, trans_avg_fit
//	
//	variable mid_occupation_x, mid_occupation_y, y_offset_diff, y_offset_setpoint = 0.2
//	variable quadratic_occupation_coef, linear_occupation_coef
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
//		cond_avg_fit = "GFit_" + cond_avg
//		trans_avg_fit = "fit_" + trans_avg
//		
//		legend_text = legend_text + "\\s(" + trans_avg_fit +  "_figc) " +  e_temp + "mK\r"
//		
//		///// getting occupation fit coefficients /////
//		occupation_coef_name = "coef_" + trans_avg
//		wave occupation_coef = $occupation_coef_name
//		///// finding mid occupation y point based on N=0.5 in x /////
////		mid_occupation_x = occupation_coef[2]
////		wave occupation_wave = $trans_avg
////		mid_occupation_y = occupation_wave(mid_occupation_x)
//
//		///// finsing mid occupation based on constant y offset in coefs /////
//		mid_occupation_y = occupation_coef[4]
//		
//		///// finsidng difference between trace setpoint and y-offset /////
//		y_offset_diff = mid_occupation_y - y_offset_setpoint
//		
//		linear_occupation_coef = occupation_coef[5]
//		quadratic_occupation_coef = occupation_coef[6]
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
//		AppendToGraph /W=figure_ca /L=l3/B=b3 $cond_avg; AppendToGraph /W=figure_ca /L=l3/B=b3 $cond_avg_fit;
//		ModifyGraph /W=figure_ca mode($cond_avg)=2, lsize($cond_avg)=1, rgb($cond_avg)=(red,green,blue)
//		ModifyGraph /W=figure_ca mode($cond_avg_fit)=0, lsize($cond_avg_fit)=2, rgb($cond_avg_fit)=(red,green,blue)
//		
//		
//		
//		//////////////////////////////////////////
//		///// ADDING OCCUPATION VS SWEEPGATE /////
//		//////////////////////////////////////////
//		///// Re-offsetting and removing quadratic and linear terms /////
//		string trans_avg_data_wave_name = trans_avg + "_figc"
//		string trans_avg_fit_wave_name = trans_avg_fit + "_figc"
//		
//		duplicate/o $trans_avg $trans_avg_data_wave_name
//		duplicate/o $trans_avg tempx
//		tempx = x
//
//		wave trans_avg_data_wave = $trans_avg_data_wave_name
//		trans_avg_data_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
//		
//		
//		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
//		duplicate/o $trans_avg_fit tempx
//		tempx = x
//		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
//		trans_avg_fit_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
//
//		///// Appending traces to graph ca /////
//		AppendToGraph /W=figure_ca /L=l2/B=b2 trans_avg_data_wave; AppendToGraph /W=figure_ca /L=l2/B=b2 trans_avg_fit_wave;
//		ModifyGraph /W=figure_ca mode($trans_avg_data_wave_name)=2, lsize($trans_avg_data_wave_name)=1, rgb($trans_avg_data_wave_name)=(red,green,blue)
//		ModifyGraph /W=figure_ca mode($trans_avg_fit_wave_name)=0, lsize($trans_avg_fit_wave_name)=2, rgb($trans_avg_fit_wave_name)=(red,green,blue)
//		
//		///// Appending traces to graph cb /////
//		AppendToGraph /W=figure_ca /L=l4/B=b4 $trans_avg; AppendToGraph /W=figure_ca /L=l4/B=b4 $trans_avg_fit;
//		ModifyGraph /W=figure_ca mode($trans_avg)=2, lsize($trans_avg)=1, rgb($trans_avg)=(red,green,blue)
//		ModifyGraph /W=figure_ca mode($trans_avg_fit)=0, lsize($trans_avg_fit)=2, rgb($trans_avg_fit)=(red,green,blue)
//		
//		
//		///////////////////////////////////////////
//		///// ADDING CONDUCTION VS OCCUPATION /////
//		///////////////////////////////////////////
//		string cond_vs_occ_data_wave_name_y = cond_avg + "condocc_data"
//		string cond_vs_occ_data_wave_name_x = "nrgocc_" + cond_avg
//		AppendToGraph /W=figure_ca /L=left/B=bottom $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x;
//		ModifyGraph /W=figure_ca mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
//		
//	endfor
//	
//	///// axis labelling goes from top plot to bottom plot
//	///// [b3, l3] [b2, l2] [bottom left]
//	
//	
//	///// setting y-scale of axis /////
//	ModifyGraph /W = figure_ca axisEnab(l3)={0.72, 1.0}
//	ModifyGraph /W = figure_ca axisEnab(l2)={0.43, 0.71}
//	ModifyGraph /W = figure_ca axisEnab(left)={0.0, 0.28}
//	
//	ModifyGraph /W = figure_ca axisEnab(l4)={0.57-0.05, 0.57+0.05}
//	ModifyGraph /W = figure_ca axisEnab(b4)={0.1,0.4}
//	
//	
//	///// setting x-axis in line with y-axis /////
//	ModifyGraph /W = figure_ca freePos(b2)={0,l3}
//	ModifyGraph /W = figure_ca freePos(b3)={0,l2}
//	
//	ModifyGraph /W = figure_ca freePos(b4)={0,l4}
//	
//	///// remove label from b2 /////
//	ModifyGraph /W = figure_ca noLabel(b2)=2
//	
//	ModifyGraph /W = figure_ca freePos(l2)=0
//	ModifyGraph /W = figure_ca freePos(l3)=0
//	
//	ModifyGraph /W = figure_ca noLabel(b4)=2
//	ModifyGraph /W = figure_ca noLabel(l4)=2
//	
//	///// setting  axis labels /////
//	Label /W=figure_ca l3 "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
//	Label /W=figure_ca l2 "Current (nA)"
//	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
//	
//	Label /W=figure_ca bottom "Occupation (.arb)"
//	Label /W=figure_ca b3 "Sweep Gate (mV)"
//	
//	///// off-setting labels from the axis /////
//	ModifyGraph /W=figure_ca lblPos(l2)=90
//	ModifyGraph /W=figure_ca lblPos(l3)=90
//	ModifyGraph /W=figure_ca lblPos(left)=90
//	ModifyGraph /W=figure_ca lblPos(bottom)=80
//	ModifyGraph /W=figure_ca lblPos(b3)=80
//	
//	
//	///// adding legend /////
//	Legend/W=figure_ca/C/N=legend_figc/J/A=LT legend_text
////	print legend_text
//end
//
//

function etemp_test()
	string gamma_over_temp_type = "high"
	string datnums = "6079;6088;6085;6082" // high gamma
//	run_clean_average_procedure(datnums=datnums)
	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
	
	variable num_temperatures = 100
	
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
		[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(e_temps[i], datnums, gamma_over_temp_type)
		
		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
		
		cond_chisq_wave[i] = cond_chisq
		occ_chisq_wave[i] = occ_chisq
		condocc_chisq_wave[i] = condocc_chisq
	endfor
	
	display
	AppendToGraph/L cond_chisq_wave vs e_temps
	AppendToGraph/R occ_chisq_wave vs e_temps
	AppendToGraph/R /L=l2, condocc_chisq_wave vs e_temps
	
	Label bottom "Electron Temp (mK)"
	Label left "Chi Squared Conductance"
	Label right "Chi Squared Occupation"
	ModifyGraph rgb(occ_chisq_wave)=(0,0,0), gFont="Calibri", gfSize=14
end



function run_global_fit_wrapper(variable baset, string datnums, string gamma_over_temp_type)
	variable cond_chisq, occ_chisq, condocc_chisq
	
//	run_clean_average_procedure(datnums=datnums)
//	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type)
	
	print "Conduction chisq = " + num2str(cond_chisq)
	print "Occupation chisq = " + num2str(occ_chisq)
end



function figure_C_separate([variable baset, string gamma_type, variable field_on])
	baset = paramisdefault(baset) ? 15 : baset
	gamma_type = selectString(paramisdefault(gamma_type), gamma_type, "high") 
	field_on = paramisdefault(field_on) ? 0 : field_on
	
	string datnums, gamma_over_temp_type
	if ((StringMatch(gamma_type, "high") == 1) &&  (field_on == 0))
		datnums = "6079;6088;6085;6082"; gamma_over_temp_type = "high" // high gamma
	elseif ((StringMatch(gamma_type, "mid") == 1) && (field_on == 0))
		datnums = "6080;6089;6086;6083"; gamma_over_temp_type = "mid" // mid gamma
	elseif ((StringMatch(gamma_type, "low") == 1) && (field_on == 0))
		datnums = "6081;6090;6087;6084"; gamma_over_temp_type = "low" // low gamma
	elseif ((StringMatch(gamma_type, "high") == 1) && (field_on == 1))
		datnums = "6100;6097;6094;6091"; gamma_over_temp_type = "high" // high gamma
	endif
	
	string e_temps = num2str(baset) + ";100;300;500"
	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
	string colour, e_temp
	variable red, green, blue
	
//	run_clean_average_procedure(datnums=datnums)
	variable cond_chisq, occ_chisq, condocc_chisq
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type)
//	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
	
	variable num_dats = ItemsInList(datnums, ";")
	
	
	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
	Display; KillWindow /Z figure_cb1; DoWindow/C/O figure_cb1
	Display; KillWindow /Z figure_cb2; DoWindow/C/O figure_cb2
	Display; KillWindow /Z figure_cc; DoWindow/C/O figure_cc

	string cond_avg, trans_avg, occ_avg, cond_avg_fit, trans_avg_fit, occ_avg_fit
	
	variable mid_occupation_x, mid_occupation_y, y_offset_diff, y_offset_setpoint = 0.0
	variable quadratic_occupation_coef, linear_occupation_coef, amplitude_occupation_coef
	string occupation_coef_name
	
	
	string legend_text = ""
	variable i, datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, datnums))
		e_temp = stringfromlist(i, e_temps)
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		occ_avg = trans_avg + "_occ"
		
		cond_avg_fit = "fit_" + cond_avg
		trans_avg_fit = "fit_" + trans_avg
		occ_avg_fit = "fit_" + occ_avg
		
		legend_text = legend_text + "\\s(" + trans_avg_fit +  "_figc) " +  e_temp + "mK\r"
		
//		///// getting occupation fit coefficients /////
//		occupation_coef_name = "coef_" + trans_avg
//		wave occupation_coef = $occupation_coef_name
//		///// finding mid occupation y point based on N=0.5 in x /////
////		mid_occupation_x = occupation_coef[2]
////		wave occupation_wave = $trans_avg
////		mid_occupation_y = occupation_wave(mid_occupation_x)
//
//		///// finsing mid occupation based on constant y offset in coefs /////
//		mid_occupation_y = occupation_coef[4]
//		
//		///// finsidng difference between trace setpoint and y-offset /////
//		y_offset_diff = mid_occupation_y - y_offset_setpoint
//		
//		linear_occupation_coef = occupation_coef[5]
//		quadratic_occupation_coef = occupation_coef[6]
//		amplitude_occupation_coef = occupation_coef[7]
		
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		
		//////////////////////////////////////////
		///// ADDING CONDUCTION VS SWEEPGATE /////
		//////////////////////////////////////////
		string cond_avg_data_wave_name = cond_avg + "_figc"
		string cond_avg_fit_wave_name = cond_avg_fit + "_figc"
		
		duplicate/o $cond_avg $cond_avg_data_wave_name
		duplicate/o $cond_avg_fit $cond_avg_fit_wave_name
		
		wave cond_avg_data_wave = $cond_avg_data_wave_name 
		wave cond_avg_fit_wave = $cond_avg_fit_wave_name 
		
		wave cond_avg_temp = $cond_avg
		wave cond_avg_fit_temp = $cond_avg_fit
		
		SetScale/I x pnt2x(cond_avg_temp, 0)/200, pnt2x(cond_avg_temp, dimsize(cond_avg_temp, 0) - 1)/200, cond_avg_data_wave // setting scale in real gate units (P*200)
		SetScale/I x pnt2x(cond_avg_fit_temp, 0)/200, pnt2x(cond_avg_fit_temp, dimsize(cond_avg_fit_temp, 0) - 1)/200, cond_avg_fit_wave  
		
		AppendToGraph /W=figure_ca $cond_avg_data_wave_name; AppendToGraph /W=figure_ca $cond_avg_fit_wave_name;
		ModifyGraph /W=figure_ca mode($cond_avg_data_wave_name)=2, lsize($cond_avg_data_wave_name)=1, rgb($cond_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($cond_avg_fit_wave_name)=0, lsize($cond_avg_fit_wave_name)=2, rgb($cond_avg_fit_wave_name)=(red,green,blue)
		
		
		
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
		
		wave occ_avg_temp = $occ_avg
		wave occ_avg_fit_temp = $occ_avg_fit
		
		///// METHOD 1 ::::: Re-offsetting and removing quadratic and linear terms /////
//		duplicate/o $trans_avg $trans_avg_data_wave_name
//		duplicate/o $trans_avg tempx
//		tempx = x
//
//		wave trans_avg_data_wave = $trans_avg_data_wave_name
//		trans_avg_data_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
//		trans_avg_data_wave /= amplitude_occupation_coef
//		
//		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
//		duplicate/o $trans_avg_fit tempx
//		tempx = x
//		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
//		trans_avg_fit_wave -= y_offset_diff + linear_occupation_coef*tempx + quadratic_occupation_coef*tempx^2
//		trans_avg_fit_wave /= amplitude_occupation_coef
//
//		///// METHOD 2 ::::: Re-fitting but with offset, linear and quadratic set to 0. /////
//		string new_occupation_coef_name = occupation_coef_name + "_duplicate"
//		duplicate/o $occupation_coef_name $new_occupation_coef_name
//		wave new_occupation_coef = $new_occupation_coef_name
//		
//		new_occupation_coef[4]=0; new_occupation_coef[5]=0; new_occupation_coef[6]=0; new_occupation_coef[7]=1;
//		
//		///// calculating data
//		duplicate/o $trans_avg $trans_avg_data_wave_name
//		duplicate/o $trans_avg tempx
//		tempx = x
//
//		wave trans_avg_data_wave = $trans_avg_data_wave_name
//		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_data_wave, tempx)
//		
//		///// calculating fit
//		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
//		duplicate/o $trans_avg_fit tempx
//		tempx = x
//
//		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
//		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_fit_wave, tempx)

		
		SetScale/I x pnt2x(occ_avg_data_wave, 0)/200, pnt2x(occ_avg_data_wave, dimsize(occ_avg_data_wave, 0) - 1)/200, occ_avg_data_wave
		SetScale/I x pnt2x(occ_avg_fit_wave, 0)/200, pnt2x(occ_avg_fit_wave, dimsize(occ_avg_fit_wave, 0) - 1)/200, occ_avg_fit_wave 
		

		///// Appending traces to graph ca /////
		AppendToGraph /W=figure_cb1 occ_avg_data_wave; AppendToGraph /W=figure_cb1 occ_avg_fit_wave;
		ModifyGraph /W=figure_cb1 mode($occ_avg_data_wave_name)=2, lsize($occ_avg_data_wave_name)=1, rgb($occ_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_cb1 mode($occ_avg_fit_wave_name)=0, lsize($occ_avg_fit_wave_name)=2, rgb($occ_avg_fit_wave_name)=(red,green,blue)
		
		
		
		
		///// adding charghe transition /////
		string trans_orig_avg_data_wave_name = trans_avg + "_figc"
		string trans_orig_avg_fit_wave_name = trans_avg_fit + "_figc"
		
		duplicate/o $trans_avg $trans_orig_avg_data_wave_name
		duplicate/o $trans_avg_fit $trans_orig_avg_fit_wave_name
		
		wave trans_orig_avg_data_wave = $trans_orig_avg_data_wave_name 
		wave trans_orig_avg_fit_wave = $trans_orig_avg_fit_wave_name 
		
		wave trans_avg_temp = $trans_avg
		wave trans_avg_fit_temp = $trans_avg_fit
		
		SetScale/I x pnt2x(trans_avg_temp, 0)/200, pnt2x(trans_avg_temp, dimsize(trans_avg_temp, 0) - 1)/200, trans_orig_avg_data_wave
		SetScale/I x pnt2x(trans_avg_fit_temp, 0)/200, pnt2x(trans_avg_fit_temp, dimsize(trans_avg_fit_temp, 0) - 1)/200, trans_orig_avg_fit_wave 
		
		///// Appending traces to graph cb /////
		AppendToGraph /W=figure_cb2 $trans_orig_avg_data_wave_name; AppendToGraph /W=figure_cb2 $trans_orig_avg_fit_wave_name;
		ModifyGraph /W=figure_cb2 mode($trans_orig_avg_data_wave_name)=2, lsize($trans_orig_avg_data_wave_name)=1, rgb($trans_orig_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_cb2 mode($trans_orig_avg_fit_wave_name)=0, lsize($trans_orig_avg_fit_wave_name)=2, rgb($trans_orig_avg_fit_wave_name)=(red,green,blue)
		
		
//		///////////////////////////////////////////
//		///// ADDING CONDUCTION VS OCCUPATION /////
//		///////////////////////////////////////////
////		string cond_vs_occ_data_wave_name_y = cond_avg + "_cond_data"
////		string cond_vs_occ_data_wave_name_x = cond_avg + "_occ_nrg"
//		string cond_vs_occ_data_wave_name_y = cond_avg
//		string cond_vs_occ_data_wave_name_x = cond_avg + "_occ_nrg"
//		
////		///// START EXTRA /////
//		duplicate /o trans_avg_data_wave $cond_vs_occ_data_wave_name_x
//		SetScale/I x pnt2x($cond_vs_occ_data_wave_name_y, 0)/200, pnt2x($cond_vs_occ_data_wave_name_y, dimsize($cond_vs_occ_data_wave_name_y, 0) - 1)/200, $cond_vs_occ_data_wave_name_y
////		crop_waves_by_x_scaling($cond_vs_occ_data_wave_name_y, $cond_vs_occ_data_wave_name_x)
////		///// END EXTRA /////
//		
//		AppendToGraph /W=figure_cc $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x;
//		ModifyGraph /W=figure_cc mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
//		
//		string cond_vs_occ_fit_wave_name_y = cond_avg + "_cond_nrg"
//		string cond_vs_occ_fit_wave_name_x = cond_avg + "_occ_nrg"
//		AppendToGraph /W=figure_cc $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
//		ModifyGraph /W=figure_cc mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(red,green,blue)
		
	endfor
	
	// tick scales https://www.wavemetrics.com/forum/general/about-axis-scale
	
	///// setting  axis labels /////
	// y - axis labels
//	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
//	Label /W=figure_cb1 left "Occupation (.arb)"
//	Label /W=figure_cb2 left "Current (nA)"
//	Label /W=figure_cc left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
	
	// x - axis labels
//	Label /W=figure_ca bottom "Sweep Gate (mV)"
//	Label /W=figure_cb1 bottom "Sweep Gate (mV)"
//	Label /W=figure_cb2 bottom "Sweep Gate (mV)"
//	Label /W=figure_cc bottom "Occupation (.arb)"
	
	// setting axis range
	SetAxis /W=figure_ca bottom -10, 10
	SetAxis /W=figure_cb1 bottom -20, 20
	SetAxis /W=figure_cb2 bottom -20, 20
	
	
//	///// off-setting labels from the axis /////
//	ModifyGraph /W=figure_ca lblPos(l2)=90
//	ModifyGraph /W=figure_ca lblPos(l3)=90
//	ModifyGraph /W=figure_ca lblPos(left)=90
//	ModifyGraph /W=figure_ca lblPos(bottom)=80
//	ModifyGraph /W=figure_ca lblPos(b3)=80
	
	
	///// adding legend /////
//	Legend/W=figure_ca/C/N=legend_figc/J/A=LT legend_text
	Legend/W=figure_cb1/C/N=legend_figc/J/A=LT legend_text
//	Legend/W=figure_cb2/C/N=legend_figc/J/A=LT legend_text
//	Legend/W=figure_cc/C/N=legend_figc/J/A=LT legend_text
//	print legend_text
end


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



function figure_D([variable baset])
	baset = paramisdefault(baset) ? 15 : baset
		
	////// data names /////
	string base_name_data_y = "_dot_cleaned_avg_figc"
	string base_name_data_x = "_cs_cleaned_avg_occ_figc"
	
	////// NRG names /////
	string base_name_fit_y = "_dot_cleaned_avg_figc"
	string base_name_fit_x = "_cs_cleaned_avg_occ_figc"
	
	string data_y, data_x, fit_y, fit_x, datnum, marker_size
	
	closeallGraphs()
	
	Display; KillWindow /Z figure_Da; DoWindow/C/O figure_Da
	Display; KillWindow /Z figure_Db; DoWindow/C/O figure_Db
	
	//////////////////////
	///// FIGURE D.A /////
	//////////////////////
	
	///// low gamma /////
	figure_C_separate(baset = baset,  gamma_type = "low") // dat 6081
	datnum = "6081"
	data_y = "dat" + datnum + base_name_data_y
	data_x = "dat" + datnum + base_name_data_x
	fit_y = "fit_dat" + datnum + base_name_fit_y
	fit_x = "fit_dat" + datnum + base_name_fit_x
	marker_size = data_y + "_marker_size"
	
	create_marker_size($data_y, 3, min_marker=0.01, max_marker=2)
	
//	AppendToGraph /W=figure_Da $data_y vs $data_x
//	AppendToGraph /W=figure_Da $fit_y vs $fit_x
	translate_wave_by_occupation($data_y, $data_x) // NOW
	AppendToGraph /W=figure_Da $data_y; AppendToGraph /W=figure_Da /r $data_x 
	translate_wave_by_occupation($fit_y, $fit_x) // NOW
	AppendToGraph /W=figure_Da $fit_y; AppendToGraph /W=figure_Da /r $fit_x 
//	
	ModifyGraph /W=figure_Da mode($data_y)=3, marker($data_y)=41, lsize($data_y)=2, zmrkSize($data_y)={$marker_size,*,*,0.01,4}, rgb($data_y)=(186*257,0,8*257)//(94*257,135*257,93*257)
	ModifyGraph /W=figure_Da mode($data_x)=3, marker($data_x)=41, lsize($data_x)=2, zmrkSize($data_x)={$marker_size,*,*,0.01,4}, rgb($data_x)=(186*257,0,8*257)//(94*257,135*257,93*257)

	ModifyGraph /W=figure_Da mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(186*257,0,8*257) //(94*257,135*257,93*257)
	ModifyGraph /W=figure_Da mode($fit_x)=0, lsize($fit_x)=2, rgb($fit_x)=(186*257,0,8*257) //(94*257,135*257,93*257)

//	///// mid gamma /////
//	figure_C_separate(baset = baset,  gamma_type = "mid") // dat 6080
//	datnum = "6080"
//	data_y = "dat" + datnum + base_name_data_y
//	data_x = "dat" + datnum + base_name_data_x
////	fit_y = "dat" + datnum + base_name_fit_y
//	fit_y = "GFit_dat" + datnum + base_name_fit_y
//	fit_x = "dat" + datnum + base_name_fit_x
//	marker_size = data_y + "_marker_size"
//	
//	create_marker_size($data_y, 3, min_marker=0.01, max_marker=2)
//	
////	AppendToGraph /W=figure_Da $data_y vs $data_x
////	AppendToGraph /W=figure_Da $fit_y vs $fit_x
//	AppendToGraph /W=figure_Da $data_y 
//	AppendToGraph /W=figure_Da $fit_y 
//	
//	ModifyGraph /W=figure_Da mode($data_y)=3, marker($data_y)=41, lsize($data_y)=2, rgb($data_y)=(205*257,132*257,48*257), zmrkSize($data_y)={$marker_size,*,*,0.01,4}
//	ModifyGraph /W=figure_Da mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(205*257,132*257,48*257)
	
	
	///// high gamma /////
	figure_C_separate(baset = baset,  gamma_type = "high") // dat 6079
	datnum = "6079"
	data_y = "dat" + datnum + base_name_data_y
	data_x = "dat" + datnum + base_name_data_x
	fit_y = "fit_dat" + datnum + base_name_fit_y
	fit_x = "fit_dat" + datnum + base_name_fit_x
	
	marker_size = data_y + "_marker_size"
	
	create_marker_size($data_y, 6, min_marker=0.01, max_marker=2)
	
//	AppendToGraph /W=figure_Da $data_y vs $data_x
//	AppendToGraph /W=figure_Da $fit_y vs $fit_x
	translate_wave_by_occupation($data_y, $data_x) // NOW
	AppendToGraph /W=figure_Da $data_y; AppendToGraph /W=figure_Da /r $data_x 
	translate_wave_by_occupation($fit_y, $fit_x) // NOW
	AppendToGraph /W=figure_Da $fit_y; AppendToGraph /W=figure_Da /r $fit_x 
	
	ModifyGraph /W=figure_Da mode($data_y)=3, marker($data_y)=41, lsize($data_y)=2, zmrkSize($data_y)={$marker_size,*,*,0.01,4}, rgb($data_y)=(58*257,107*257,134*257) //(186*257,0*257,8*257), zmrkSize($data_y)={$marker_size,*,*,0.01,4}
	ModifyGraph /W=figure_Da mode($data_x)=3, marker($data_x)=41, lsize($data_x)=2, zmrkSize($data_x)={$marker_size,*,*,0.01,4}, rgb($data_x)=(58*257,107*257,134*257) //(186*257,0*257,8*257), zmrkSize($data_y)={$marker_size,*,*,0.01,4}

	ModifyGraph /W=figure_Da mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(58*257,107*257,134*257) //(186*257,0*257,8*257)
	ModifyGraph /W=figure_Da mode($fit_x)=0, lsize($fit_x)=2, rgb($fit_x)=(58*257,107*257,134*257) //(186*257,0*257,8*257)
	
//	SetAxis /W=figure_Da bottom -5, 2
	SetAxis /W=figure_Da bottom -5, 2
	SetAxis /W=figure_Da right 0, 1
	
	closeallGraphs(no_close_graphs="figure_Da;figure_Db")
	
//	Label /W=figure_Da bottom "Occupation"
//	Label /W=figure_Da left "Conductance (\\$WMTEX$ 2e^2/h \\$/WMTEX$)"
//	Legend /W=figure_Da/C/N=text0/A=LT/X=4.62/Y=6.37/J "\\s(dat6081_dot_cleaned_avgcondocc_nrg_y) Γ/T = 2\r\\s(dat6080_dot_cleaned_avgcondocc_nrg_y) Γ/T = 11 \r\\s(dat6079_dot_cleaned_avgcondocc_nrg_y) Γ/T = 28"
//	Legend /W=figure_Da/C/N=text0/A=LT/X=4.62/Y=6.37/J "\\s(fit_dat6081_dot_cleaned_avg_figc) Γ/T = 2\r\\s(fit_dat6080_dot_cleaned_avg_figc) Γ/T = 11 \r\\s(fit_dat6079_dot_cleaned_avg_figc) Γ/T = 28"
	Legend /W=figure_Da/C/N=text0/A=LT/X=4.62/Y=6.37/J "\\s(fit_dat6081_dot_cleaned_avg_figc) Γ/T = low\r\\s(fit_dat6079_dot_cleaned_avg_figc) Γ/T = high"

	
	ModifyGraph /W=figure_Da mirror=0, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=14, tick=2, gFont="Calibri", gfSize=14 // Mirror unticked

	
	//////////////////////
	///// FIGURE D.B /////
	//////////////////////
	
//	///// high gamma low field /////
//	figure_C_separate(baset = baset,  gamma_type = "high") // dat 6079
//	datnum = "6079"
//	data_y = "dat" + datnum + base_name_data_y
//	data_x = "nrgocc_dat" + datnum + base_name_data_x
//	fit_y = "dat" + datnum + base_name_fit_y
//	fit_x = "dat" + datnum + base_name_fit_x
//	marker_size = data_y + "_marker_size"
//	
//	create_marker_size($data_y, 6, min_marker=0.01, max_marker=2)
//	
//	AppendToGraph /W=figure_Db $data_y vs $data_x
////	AppendToGraph /W=figure_Db $fit_y vs $fit_x
//	ModifyGraph /W=figure_Db mode($data_y)=3, marker($data_y)=41, lsize($data_y)=2, rgb($data_y)=(186*257,0*257,8*257), zmrkSize($data_y)={$marker_size,*,*,0.01,4}, gFont="Calibri", gfSize=14
////	ModifyGraph /W=figure_Db mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(186*257,0*257,8*257)
//	
//	///// high gamma high field /////
//	figure_C_separate(baset = baset,  gamma_type = "high", field_on = 1) // dat 6100
//	datnum = "6100"
//	data_y = "dat" + datnum + base_name_data_y
//	data_x = "nrgocc_dat" + datnum + base_name_data_x
//	fit_y = "dat" + datnum + base_name_fit_y
//	fit_x = "dat" + datnum + base_name_fit_x
//	marker_size = data_y + "_marker_size"
//	
//	create_marker_size($data_y, 6, min_marker=0.01, max_marker=2)
//	
//	AppendToGraph /W=figure_Db $data_y vs $data_x
////	AppendToGraph /W=figure_Db $fit_y vs $fit_x
//	ModifyGraph /W=figure_Db mode($data_y)=3, marker($data_y)=13,  lsize($data_y)=2, rgb($data_y)=(159*257,139*257,193*257), zmrkSize($data_y)={$marker_size,*,*,0.01,4}, gFont="Calibri", gfSize=14
////	ModifyGraph /W=figure_Db mode($fit_y)=0, lsize($fit_y)=2, rgb($fit_y)=(186*257,0*257,8*257)
//	
//	closeallGraphs(no_close_graphs="figure_Da;figure_Db")	
//	
////	Label /W=figure_Db bottom "Occupation"
////	Label /W=figure_Db left "Conductance (\\$WMTEX$ 2e^2/ℏ \\$/WMTEX$)"
//	
//	
//	Legend /W=figure_Db/C/N=text0/A=LT/X=4.62/Y=6.37/J "\\s(dat6079_dot_cleaned_avgcondocc_data) Data 70mT\r\\s(dat6100_dot_cleaned_avgcondocc_data) Data 2000mT"
//	ModifyGraph /W=figure_Db mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=14, tick=2, gFont="Calibri", gfSize=14
//
////	Legend /W=figure_Db/C/N=text0/A=LT/X=4.62/Y=6.37/J "\\s(dat6079_dot_cleaned_avgcondocc_data) Data 70mT\r\\s(dat6100_dot_cleaned_avgcondocc_data) Data 2000mT\r\\s(dat6079_dot_cleaned_avgcondocc_nrg_y) NRG"

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