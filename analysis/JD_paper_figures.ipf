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
	ModifyGraph rgb(occ_chisq_wave)=(0,0,0)
end



function run_global_fit_wrapper(variable baset, string datnums, string gamma_over_temp_type)
	variable cond_chisq, occ_chisq, condocc_chisq
	
	run_clean_average_procedure(datnums=datnums)
	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
//	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type)
//	
//	print "Conduction chisq = " + num2str(cond_chisq)
//	print "Occupation chisq = " + num2str(occ_chisq)
end



function figure_C_separate([variable baset])
	baset = paramisdefault(baset) ? 15 : baset
	
//	string datnums = "6079;6088;6085;6082"; string gamma_over_temp_type = "high" // high gamma
//	string datnums = "6080;6089;6086;6083"; string gamma_over_temp_type = "mid" // mid gamma
	string datnums = "6081;6090;6087;6084"; string gamma_over_temp_type = "low" // low gamma
	string e_temps = num2str(baset) + ";100;300;500"
	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
	string colour, e_temp
	variable red, green, blue
	
//	run_clean_average_procedure(datnums=datnums)
	variable cond_chisq, occ_chisq, condocc_chisq
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type)
	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
	
	variable num_dats = ItemsInList(datnums, ";")
	
	
	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
	Display; KillWindow /Z figure_cb1; DoWindow/C/O figure_cb1
	Display; KillWindow /Z figure_cb2; DoWindow/C/O figure_cb2
	Display; KillWindow /Z figure_cc; DoWindow/C/O figure_cc

	string cond_avg, trans_avg, cond_avg_fit, trans_avg_fit
	
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
		cond_avg_fit = "GFit_" + cond_avg
		trans_avg_fit = "fit_" + trans_avg
		
		legend_text = legend_text + "\\s(" + trans_avg_fit +  "_figc) " +  e_temp + "mK\r"
		
		///// getting occupation fit coefficients /////
		occupation_coef_name = "coef_" + trans_avg
		wave occupation_coef = $occupation_coef_name
		///// finding mid occupation y point based on N=0.5 in x /////
//		mid_occupation_x = occupation_coef[2]
//		wave occupation_wave = $trans_avg
//		mid_occupation_y = occupation_wave(mid_occupation_x)

		///// finsing mid occupation based on constant y offset in coefs /////
		mid_occupation_y = occupation_coef[4]
		
		///// finsidng difference between trace setpoint and y-offset /////
		y_offset_diff = mid_occupation_y - y_offset_setpoint
		
		linear_occupation_coef = occupation_coef[5]
		quadratic_occupation_coef = occupation_coef[6]
		amplitude_occupation_coef = occupation_coef[7]
		
		
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
		
		SetScale/I x pnt2x(cond_avg_temp, 0)/200, pnt2x(cond_avg_temp, dimsize(cond_avg_temp, 0) - 1)/200, cond_avg_data_wave
		SetScale/I x pnt2x(cond_avg_fit_temp, 0)/200, pnt2x(cond_avg_fit_temp, dimsize(cond_avg_fit_temp, 0) - 1)/200, cond_avg_fit_wave  
		
		AppendToGraph /W=figure_ca $cond_avg_data_wave_name; AppendToGraph /W=figure_ca $cond_avg_fit_wave_name;
		ModifyGraph /W=figure_ca mode($cond_avg_data_wave_name)=2, lsize($cond_avg_data_wave_name)=1, rgb($cond_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($cond_avg_fit_wave_name)=0, lsize($cond_avg_fit_wave_name)=2, rgb($cond_avg_fit_wave_name)=(red,green,blue)
		
		
		
		//////////////////////////////////////////
		///// ADDING OCCUPATION VS SWEEPGATE /////
		//////////////////////////////////////////
		string trans_avg_data_wave_name = trans_avg + "_figc"
		string trans_avg_fit_wave_name = trans_avg_fit + "_figc"
		
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

		///// METHOD 2 ::::: Re-fitting but with offset, linear and quadratic set to 0. /////
		string new_occupation_coef_name = occupation_coef_name + "_duplicate"
		duplicate/o $occupation_coef_name $new_occupation_coef_name
		wave new_occupation_coef = $new_occupation_coef_name
		
		new_occupation_coef[4]=0; new_occupation_coef[5]=0; new_occupation_coef[6]=0; new_occupation_coef[7]=1;
		
		///// calculating data
		duplicate/o $trans_avg $trans_avg_data_wave_name
		duplicate/o $trans_avg tempx
		tempx = x

		wave trans_avg_data_wave = $trans_avg_data_wave_name
		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_data_wave, tempx)
		
		///// calculating fit
		duplicate/o $trans_avg_fit $trans_avg_fit_wave_name
		duplicate/o $trans_avg_fit tempx
		tempx = x

		wave trans_avg_fit_wave = $trans_avg_fit_wave_name
		fitfunc_nrgctAAO(new_occupation_coef, trans_avg_fit_wave, tempx)

		
		SetScale/I x pnt2x(trans_avg_data_wave, 0)/200, pnt2x(trans_avg_data_wave, dimsize(trans_avg_data_wave, 0) - 1)/200, trans_avg_data_wave
		SetScale/I x pnt2x(trans_avg_fit_wave, 0)/200, pnt2x(trans_avg_fit_wave, dimsize(trans_avg_fit_wave, 0) - 1)/200, trans_avg_fit_wave 
		

		///// Appending traces to graph ca /////
		AppendToGraph /W=figure_cb1 trans_avg_data_wave; AppendToGraph /W=figure_cb1 trans_avg_fit_wave;
		ModifyGraph /W=figure_cb1 mode($trans_avg_data_wave_name)=2, lsize($trans_avg_data_wave_name)=1, rgb($trans_avg_data_wave_name)=(red,green,blue)
		ModifyGraph /W=figure_cb1 mode($trans_avg_fit_wave_name)=0, lsize($trans_avg_fit_wave_name)=2, rgb($trans_avg_fit_wave_name)=(red,green,blue)
		
		
		
		string trans_orig_avg_data_wave_name = trans_avg + "_original_figc"
		string trans_orig_avg_fit_wave_name = trans_avg_fit + "_original_figc"
		
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
		
		
		///////////////////////////////////////////
		///// ADDING CONDUCTION VS OCCUPATION /////
		///////////////////////////////////////////
		string cond_vs_occ_data_wave_name_y = cond_avg + "condocc_data"
		string cond_vs_occ_data_wave_name_x = "nrgocc_" + cond_avg
		AppendToGraph /W=figure_cc $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x;
		ModifyGraph /W=figure_cc mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
		
		string cond_vs_occ_fit_wave_name_y = cond_avg + "condocc_nrg_y"
		string cond_vs_occ_fit_wave_name_x = cond_avg + "condocc_nrg_x"
		AppendToGraph /W=figure_cc $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
		ModifyGraph /W=figure_cc mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(red,green,blue)
		
	endfor
	
	// tick scales https://www.wavemetrics.com/forum/general/about-axis-scale
	
	///// setting  axis labels /////
	// y - axis labels
	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
	Label /W=figure_cb1 left "Current (nA)"
	Label /W=figure_cb2 left "Current (nA)"
	Label /W=figure_cc left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$   / h)"
	
	// x - axis labels
	Label /W=figure_ca bottom "Sweep Gate (mV)"
	Label /W=figure_cb1 bottom "Occupation (.arb)"
	Label /W=figure_cb2 bottom "Sweep Gate (mV)"
	Label /W=figure_cc bottom "Occupation (.arb)"
	
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
