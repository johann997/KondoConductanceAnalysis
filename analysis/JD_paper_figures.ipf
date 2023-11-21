#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>

//1281
//base	90	275	400
//1285	1297 	1293	 1289
//
//1282
//base	90	275	400
//1286	1298 	1294	 1290
//
//1283
//base	90	275	400
//1287	1299 	1295	 1291
//
//1284
//base	90	275	400
//1288	1300	 1296 1292


function beautify_figure(figure_name)
	string figure_name
	int font_size = 8
//	ModifyGraph /W=$figure_name mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph /W=$figure_name mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=font_size, tick=2, gFont="Calibri", gfSize=font_size, lowTrip(bottom)=0.0001, width=200, height=200/1.6180339887
end

macro default_layout(layout_name)
	string layout_name
//	layout_name = "test"
//	int font_size = 8
////	ModifyGraph /W=$figure_name mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
//	ModifyGraph /W=$figure_name mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=font_size, tick=2, gFont="Calibri", gfSize=font_size, lowTrip(bottom)=0.0001, width=200, height=200/1.5
//	NewLayout/W=(663,53,1691,903)
	NewLayout/N=$layout_name /W=(288,53,792,903)
	LayoutPageAction /W=$layout_name size=(288, 792)//, margins(-1)=(18, 18, 18, 18)
//	ModifyLayout /W=layout_name width=504
//	LayoutPageAction size(-1)=(288, 720), margins(-1)=(18, 18, 18, 18)
end

//macro graphdefault()
////	ModifyGraph gFont="Helvetica",width=188,height=116
//	ModifyGraph font="Helvetica"
//	ModifyGraph fSize=8
//	ModifyGraph lowTrip(bottom)=0.1
//	ModifyGraph lsize=0.5, mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=8, tick=2
//	
//
//	Label left "\\$WMTEX$ \\Delta S (k_B)\\F'Helvetica'\\Z08\\$/WMTEX$"
//	Label bottom "\\$WMTEX$ V_{\epsilon}(mV)\\F'Helvetica'\\Z08\\$/WMTEX$"
//
//	
//	endmacro
	

function save_figure(figure_name)
	string figure_name
	
	string png_name = figure_name + ".png"
//	string data
	
//	PathInfo data
//	print ParseFilePath(1, S_path, ":", 1, 0)
//	string /G S_path
//	string file_path = ParseFilePath(1, S_path, ":", 1, 0) + "Figures:"
	string file_path = "Macintosh HD:Users:johanndrayne:Documents:Work:QDEV:_EntropyConductancePaper:IGORAnalysis:IGOR_Figures:"
	
	SavePICT/P=figure_folder/E=-5/RES=1000/o as png_name
end


macro paper_v1_figure_2a_midweak()
// mid weak :: 1286	1298 1294 1290

// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_2a; DoWindow/C/O paper_figure_2a 
	
	
	/////// charge transition //////
	///// append data
	AppendToGraph /W=paper_figure_2a dat1286_cs_cleaned_avg; 
	AppendToGraph /W=paper_figure_2a dat1298_cs_cleaned_avg; 
	AppendToGraph /W=paper_figure_2a dat1294_cs_cleaned_avg; 
	AppendToGraph /W=paper_figure_2a dat1290_cs_cleaned_avg; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2a GFit_dat1286_cs_cleaned_avg;
	AppendToGraph /W=paper_figure_2a GFit_dat1298_cs_cleaned_avg; 
	AppendToGraph /W=paper_figure_2a GFit_dat1294_cs_cleaned_avg; 
	AppendToGraph /W=paper_figure_2a GFit_dat1290_cs_cleaned_avg;
	
	// modify data
	ModifyGraph /W=paper_figure_2a mode(dat1286_cs_cleaned_avg)=2, lsize(dat1286_cs_cleaned_avg)=1, rgb(dat1286_cs_cleaned_avg)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(dat1298_cs_cleaned_avg)=2, lsize(dat1298_cs_cleaned_avg)=1, rgb(dat1298_cs_cleaned_avg)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(dat1294_cs_cleaned_avg)=2, lsize(dat1294_cs_cleaned_avg)=1, rgb(dat1294_cs_cleaned_avg)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(dat1290_cs_cleaned_avg)=2, lsize(dat1290_cs_cleaned_avg)=1, rgb(dat1290_cs_cleaned_avg)=(65535,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1286_cs_cleaned_avg)=0, lsize(GFit_dat1286_cs_cleaned_avg)=2, rgb(GFit_dat1286_cs_cleaned_avg)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1298_cs_cleaned_avg)=0, lsize(GFit_dat1298_cs_cleaned_avg)=2, rgb(GFit_dat1298_cs_cleaned_avg)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1294_cs_cleaned_avg)=0, lsize(GFit_dat1294_cs_cleaned_avg)=2, rgb(GFit_dat1294_cs_cleaned_avg)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1290_cs_cleaned_avg)=0, lsize(GFit_dat1290_cs_cleaned_avg)=2, rgb(GFit_dat1290_cs_cleaned_avg)=(65535,0,0)
	
	Label /W=paper_figure_2a left "Current (nA)"
	
	Legend /W=paper_figure_2a /C/N=text0/J/F=0 "\\s(GFit_dat1286_cs_cleaned_avg) 22.5 mK\r\\s(GFit_dat1298_cs_cleaned_avg) 90 mK\r\\s(GFit_dat1294_cs_cleaned_avg) 275 mK\r\\s(GFit_dat1290_cs_cleaned_avg) 400 mK"
	
	
	//////////////////////////// occupation ///////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_2a dat1286_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat1298_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat1294_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat1290_cs_cleaned_avg_occ; 
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_2a GFit_dat1286_cs_cleaned_avg_occ;
//	AppendToGraph /W=paper_figure_2a GFit_dat1298_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a GFit_dat1294_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a GFit_dat1290_cs_cleaned_avg_occ;
//	
//	// modify data
//	ModifyGraph /W=paper_figure_2a mode(dat1286_cs_cleaned_avg_occ)=2, lsize(dat1286_cs_cleaned_avg_occ)=1, rgb(dat1286_cs_cleaned_avg_occ)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(dat1298_cs_cleaned_avg_occ)=2, lsize(dat1298_cs_cleaned_avg_occ)=1, rgb(dat1298_cs_cleaned_avg_occ)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(dat1294_cs_cleaned_avg_occ)=2, lsize(dat1294_cs_cleaned_avg_occ)=1, rgb(dat1294_cs_cleaned_avg_occ)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(dat1290_cs_cleaned_avg_occ)=2, lsize(dat1290_cs_cleaned_avg_occ)=1, rgb(dat1290_cs_cleaned_avg_occ)=(65535,0,0)
//	
//	// modify fits
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1286_cs_cleaned_avg_occ)=0, lsize(GFit_dat1286_cs_cleaned_avg_occ)=2, rgb(GFit_dat1286_cs_cleaned_avg_occ)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1298_cs_cleaned_avg_occ)=0, lsize(GFit_dat1298_cs_cleaned_avg_occ)=2, rgb(GFit_dat1298_cs_cleaned_avg_occ)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1294_cs_cleaned_avg_occ)=0, lsize(GFit_dat1294_cs_cleaned_avg_occ)=2, rgb(GFit_dat1294_cs_cleaned_avg_occ)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1290_cs_cleaned_avg_occ)=0, lsize(GFit_dat1290_cs_cleaned_avg_occ)=2, rgb(GFit_dat1290_cs_cleaned_avg_occ)=(65535,0,0)
//	
//	Label /W=paper_figure_2a left "Occupation (.arb)"
//	
//	Legend /W=paper_figure_2a /C/N=text0/J/F=0 "\\s(GFit_dat1286_cs_cleaned_avg_occ) 22.5 mK\r\\s(GFit_dat1298_cs_cleaned_avg_occ) 90 mK\r\\s(GFit_dat1294_cs_cleaned_avg_occ) 275 mK\r\\s(GFit_dat1290_cs_cleaned_avg_occ) 400 mK"
	//////////////////////////////////////////////////////////////////////
	
	
	Label /W=paper_figure_2a bottom "Sweepgate (mV)"
	
	beautify_figure("paper_figure_2a")
	
	save_figure("paper_figure_2a")
	// dat1282_numerical_entropy_avg_interp vs dat1282_cs_cleaned_avg_occ_interp
// fit_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
// fit_nrg_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
endmacro


macro paper_v1_figure_2b_midweak()

	Display; KillWindow /Z paper_figure_2b; DoWindow/C/O paper_figure_2b 
	
	///// append data
	Append /W=paper_figure_2b dat1282_numerical_entropy_avg_interp; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2b fit_dat1282_numerical_entropy_avg_interp;
	AppendToGraph /W=paper_figure_2b fit_nrg_dat1282_numerical_entropy_avg_interp;
	
	// modify data
	ModifyGraph /W=paper_figure_2b mode(dat1282_numerical_entropy_avg_interp)=2, lsize(dat1282_numerical_entropy_avg_interp)=1, rgb(dat1282_numerical_entropy_avg_interp)=(0,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2b mode(fit_dat1282_numerical_entropy_avg_interp)=0, lsize(fit_dat1282_numerical_entropy_avg_interp)=2, rgb(fit_dat1282_numerical_entropy_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_2b mode(fit_nrg_dat1282_numerical_entropy_avg_interp)=0, lsize(fit_nrg_dat1282_numerical_entropy_avg_interp)=2, rgb(fit_nrg_dat1282_numerical_entropy_avg_interp)=(65535,0,0)
	
	Legend /W=paper_figure_2b/C/N=text0/J/F=0 "\\s(dat1282_numerical_entropy_avg_interp) data\r\\s(fit_dat1282_numerical_entropy_avg_interp) fit from CT\r\\s(fit_nrg_dat1282_numerical_entropy_avg_interp) direct fit from CT"
	Label /W=paper_figure_2b bottom "Sweepgate (mV)"
	Label /W=paper_figure_2b left "dN/dT"
	
	beautify_figure("paper_figure_2b")
endmacro


macro paper_v1_figure_2c_midweak()

	Display; KillWindow /Z paper_figure_2c; DoWindow/C/O paper_figure_2c 
	
	///// append data
	Append /W=paper_figure_2c dat1282_numerical_entropy_avg_interp vs dat1282_cs_cleaned_avg_occ_interp; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2c fit_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_2c fit_nrg_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp;
	
	// modify data
	ModifyGraph /W=paper_figure_2c mode(dat1282_numerical_entropy_avg_interp)=2, lsize(dat1282_numerical_entropy_avg_interp)=1, rgb(dat1282_numerical_entropy_avg_interp)=(0,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2c mode(fit_dat1282_numerical_entropy_avg_interp)=0, lsize(fit_dat1282_numerical_entropy_avg_interp)=2, rgb(fit_dat1282_numerical_entropy_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_2c mode(fit_nrg_dat1282_numerical_entropy_avg_interp)=0, lsize(fit_nrg_dat1282_numerical_entropy_avg_interp)=2, rgb(fit_nrg_dat1282_numerical_entropy_avg_interp)=(65535,0,0)
	
	Legend /W=paper_figure_2c/C/N=text0/J/F=0 "\\s(dat1282_numerical_entropy_avg_interp) data\r\\s(fit_dat1282_numerical_entropy_avg_interp) fit from CT\r\\s(fit_nrg_dat1282_numerical_entropy_avg_interp) direct fit"
	Label /W=paper_figure_2c bottom "Sweepgate (mV)"
	Label /W=paper_figure_2c left "dN/dT"
	
	beautify_figure("paper_figure_2c")
endmacro


macro paper_v1_figure_2a_strong()
// strong :: 1288	1300	 1296 1292

// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_2a; DoWindow/C/O paper_figure_2a 
	
	
	/////// charge transition //////
	///// append data
//	AppendToGraph /W=paper_figure_2a dat1288_cs_cleaned_avg; 
//	AppendToGraph /W=paper_figure_2a dat1300_cs_cleaned_avg; 
//	AppendToGraph /W=paper_figure_2a dat1296_cs_cleaned_avg; 
//	AppendToGraph /W=paper_figure_2a dat1292_cs_cleaned_avg; 
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_2a GFit_dat1288_cs_cleaned_avg;
//	AppendToGraph /W=paper_figure_2a GFit_dat1300_cs_cleaned_avg; 
//	AppendToGraph /W=paper_figure_2a GFit_dat1296_cs_cleaned_avg; 
//	AppendToGraph /W=paper_figure_2a GFit_dat1292_cs_cleaned_avg;
//	
//	// modify data
//	ModifyGraph /W=paper_figure_2a mode(dat1288_cs_cleaned_avg)=2, lsize(dat1288_cs_cleaned_avg)=1, rgb(dat1288_cs_cleaned_avg)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(dat1300_cs_cleaned_avg)=2, lsize(dat1300_cs_cleaned_avg)=1, rgb(dat1300_cs_cleaned_avg)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(dat1296_cs_cleaned_avg)=2, lsize(dat1296_cs_cleaned_avg)=1, rgb(dat1296_cs_cleaned_avg)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(dat1292_cs_cleaned_avg)=2, lsize(dat1292_cs_cleaned_avg)=1, rgb(dat1292_cs_cleaned_avg)=(65535,0,0)
//	
//	// modify fits
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1288_cs_cleaned_avg)=0, lsize(GFit_dat1288_cs_cleaned_avg)=2, rgb(GFit_dat1288_cs_cleaned_avg)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1300_cs_cleaned_avg)=0, lsize(GFit_dat1300_cs_cleaned_avg)=2, rgb(GFit_dat1300_cs_cleaned_avg)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1296_cs_cleaned_avg)=0, lsize(GFit_dat1296_cs_cleaned_avg)=2, rgb(GFit_dat1296_cs_cleaned_avg)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(GFit_dat1292_cs_cleaned_avg)=0, lsize(GFit_dat1292_cs_cleaned_avg)=2, rgb(GFit_dat1292_cs_cleaned_avg)=(65535,0,0)
//	
//	Label /W=paper_figure_2a left "Current (nA)"
//	
//	Legend /W=paper_figure_2a /C/N=text0/J/F=0 "\\s(GFit_dat1288_cs_cleaned_avg) 22.5 mK\r\\s(GFit_dat1300_cs_cleaned_avg) 90 mK\r\\s(GFit_dat1296_cs_cleaned_avg) 275 mK\r\\s(GFit_dat1292_cs_cleaned_avg) 400 mK"
	
	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_2a dat1288_cs_cleaned_avg_occ; 
	AppendToGraph /W=paper_figure_2a dat1300_cs_cleaned_avg_occ; 
	AppendToGraph /W=paper_figure_2a dat1296_cs_cleaned_avg_occ; 
	AppendToGraph /W=paper_figure_2a dat1292_cs_cleaned_avg_occ; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2a GFit_dat1288_cs_cleaned_avg_occ;
	AppendToGraph /W=paper_figure_2a GFit_dat1300_cs_cleaned_avg_occ; 
	AppendToGraph /W=paper_figure_2a GFit_dat1296_cs_cleaned_avg_occ; 
	AppendToGraph /W=paper_figure_2a GFit_dat1292_cs_cleaned_avg_occ;
	
	// modify data
	ModifyGraph /W=paper_figure_2a mode(dat1288_cs_cleaned_avg_occ)=2, lsize(dat1288_cs_cleaned_avg_occ)=1, rgb(dat1288_cs_cleaned_avg_occ)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(dat1300_cs_cleaned_avg_occ)=2, lsize(dat1300_cs_cleaned_avg_occ)=1, rgb(dat1300_cs_cleaned_avg_occ)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(dat1296_cs_cleaned_avg_occ)=2, lsize(dat1296_cs_cleaned_avg_occ)=1, rgb(dat1296_cs_cleaned_avg_occ)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(dat1292_cs_cleaned_avg_occ)=2, lsize(dat1292_cs_cleaned_avg_occ)=1, rgb(dat1292_cs_cleaned_avg_occ)=(65535,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1288_cs_cleaned_avg_occ)=0, lsize(GFit_dat1288_cs_cleaned_avg_occ)=2, rgb(GFit_dat1288_cs_cleaned_avg_occ)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1300_cs_cleaned_avg_occ)=0, lsize(GFit_dat1300_cs_cleaned_avg_occ)=2, rgb(GFit_dat1300_cs_cleaned_avg_occ)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1296_cs_cleaned_avg_occ)=0, lsize(GFit_dat1296_cs_cleaned_avg_occ)=2, rgb(GFit_dat1296_cs_cleaned_avg_occ)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(GFit_dat1292_cs_cleaned_avg_occ)=0, lsize(GFit_dat1292_cs_cleaned_avg_occ)=2, rgb(GFit_dat1292_cs_cleaned_avg_occ)=(65535,0,0)
	
	Label /W=paper_figure_2a left "Occupation (.arb)"
	
	Legend /W=paper_figure_2a /C/N=text0/J/F=0 "\\s(GFit_dat1288_cs_cleaned_avg_occ) 22.5 mK\r\\s(GFit_dat1300_cs_cleaned_avg_occ) 90 mK\r\\s(GFit_dat1296_cs_cleaned_avg_occ) 275 mK\r\\s(GFit_dat1292_cs_cleaned_avg_occ) 400 mK"
	//////////////////////////////////////////////////////////////////////
	
	
	Label /W=paper_figure_2a bottom "Sweepgate (mV)"
	
	beautify_figure("paper_figure_2a")
	// dat1282_numerical_entropy_avg_interp vs dat1282_cs_cleaned_avg_occ_interp
// fit_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
// fit_nrg_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
endmacro


macro paper_v1_figure_2b_strong()

	Display; KillWindow /Z paper_figure_2b; DoWindow/C/O paper_figure_2b 
	
	///// append data
	Append /W=paper_figure_2b dat1284_numerical_entropy_avg_interp; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2b fit_dat1284_numerical_entropy_avg_interp;
	AppendToGraph /W=paper_figure_2b fit_nrg_dat1284_numerical_entropy_avg_interp;
	
	// modify data
	ModifyGraph /W=paper_figure_2b mode(dat1284_numerical_entropy_avg_interp)=2, lsize(dat1284_numerical_entropy_avg_interp)=1, rgb(dat1284_numerical_entropy_avg_interp)=(0,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2b mode(fit_dat1284_numerical_entropy_avg_interp)=0, lsize(fit_dat1284_numerical_entropy_avg_interp)=2, rgb(fit_dat1284_numerical_entropy_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_2b mode(fit_nrg_dat1284_numerical_entropy_avg_interp)=0, lsize(fit_nrg_dat1284_numerical_entropy_avg_interp)=2, rgb(fit_nrg_dat1284_numerical_entropy_avg_interp)=(65535,0,0)
	
	Legend /W=paper_figure_2b/C/N=text0/J/F=0 "\\s(dat1284_numerical_entropy_avg_interp) data\r\\s(fit_dat1284_numerical_entropy_avg_interp) fit from CT\r\\s(fit_nrg_dat1284_numerical_entropy_avg_interp) direct fit from CT"
	Label /W=paper_figure_2b bottom "Sweepgate (mV)"
	Label /W=paper_figure_2b left "dN/dT"
	
	beautify_figure("paper_figure_2b")
endmacro


macro paper_v1_figure_2c_strong()

	Display; KillWindow /Z paper_figure_2c; DoWindow/C/O paper_figure_2c 
	
	///// append data
	Append /W=paper_figure_2c dat1284_numerical_entropy_avg_interp vs dat1284_cs_cleaned_avg_occ_interp; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2c fit_dat1284_numerical_entropy_avg_interp vs fit_dat1284_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_2c fit_nrg_dat1284_numerical_entropy_avg_interp vs fit_dat1284_cs_cleaned_avg_occ_interp;
	
	// modify data
	ModifyGraph /W=paper_figure_2c mode(dat1284_numerical_entropy_avg_interp)=2, lsize(dat1284_numerical_entropy_avg_interp)=1, rgb(dat1284_numerical_entropy_avg_interp)=(0,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2c mode(fit_dat1284_numerical_entropy_avg_interp)=0, lsize(fit_dat1284_numerical_entropy_avg_interp)=2, rgb(fit_dat1284_numerical_entropy_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_2c mode(fit_nrg_dat1284_numerical_entropy_avg_interp)=0, lsize(fit_nrg_dat1284_numerical_entropy_avg_interp)=2, rgb(fit_nrg_dat1284_numerical_entropy_avg_interp)=(65535,0,0)
	
	Legend /W=paper_figure_2c/C/N=text0/J/F=0 "\\s(dat1284_numerical_entropy_avg_interp) data\r\\s(fit_dat1284_numerical_entropy_avg_interp) fit from CT\r\\s(fit_nrg_dat1284_numerical_entropy_avg_interp) direct fit"
	Label /W=paper_figure_2c bottom "Sweepgate (mV)"
	Label /W=paper_figure_2c left "dN/dT"
	
	beautify_figure("paper_figure_2c")
endmacro


macro paper_v1_figure_3()
// entropy 1281 1282 1283 1284

	Display; KillWindow /Z paper_figure_dndt_noscale; DoWindow/C/O paper_figure_dndt_noscale 
	Display; KillWindow /Z paper_figure_dndt_scale; DoWindow/C/O paper_figure_dndt_scale 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled
	
	///// non-scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_noscaled
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_noscaled
	
	// offset to 0
	dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	fit_dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	fit_dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	fit_dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	// scale everything by the maximum fit value
	dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	fit_dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	fit_dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	fit_dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	fit_dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	// offset everything
	variable offset = 0
	dat1281_numerical_entropy_avg_interp_scaled += offset * 0
	dat1282_numerical_entropy_avg_interp_scaled += offset * 1
	dat1283_numerical_entropy_avg_interp_scaled += offset * 2
	dat1284_numerical_entropy_avg_interp_scaled += offset * 3
	
	fit_dat1281_numerical_entropy_avg_interp_scaled += offset * 0
	fit_dat1282_numerical_entropy_avg_interp_scaled += offset * 1
	fit_dat1283_numerical_entropy_avg_interp_scaled += offset * 2
	fit_dat1284_numerical_entropy_avg_interp_scaled += offset * 3
	
	
//	resampleWave(dat1281_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1282_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1283_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1284_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
	
	smooth 500, dat1281_numerical_entropy_avg_interp_scaled
	smooth 500, dat1282_numerical_entropy_avg_interp_scaled
	smooth 500, dat1283_numerical_entropy_avg_interp_scaled
	smooth 500, dat1284_numerical_entropy_avg_interp_scaled
	
	////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	
//	/////// sweepgate //////
	///// translate data
	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_scaled, dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_scaled, dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_scaled, dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_scaled, dat1284_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_scaled, fit_dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_scaled, fit_dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_scaled, fit_dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_scaled, fit_dat1284_cs_cleaned_avg_occ_interp) 
	///// append data
	AppendToGraph /W=paper_figure_dndt_scale dat1281_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale dat1282_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale dat1283_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale dat1284_numerical_entropy_avg_interp_scaled
	
	///// append fits
	AppendToGraph /W=paper_figure_dndt_scale fit_dat1281_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale fit_dat1282_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale fit_dat1283_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_dndt_scale fit_dat1284_numerical_entropy_avg_interp_scaled
	
	Label /W=paper_figure_dndt_scale bottom "Sweepgate (mV)"
	
	
	///// adding inset
	///// translate data
	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_noscaled, dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_noscaled, dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_noscaled, dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_noscaled, dat1284_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_noscaled, fit_dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_noscaled, fit_dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_noscaled, fit_dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_noscaled, fit_dat1284_cs_cleaned_avg_occ_interp) 

//	///// append data
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled
//	
//	ModifyGraph /W=paper_figure_dndt_scale  axisEnab(l1)={0.5,0.9},axisEnab(b1)={0.1,0.4},freePos(l1)={-25,b1},freePos(b1)={-0.0021,l1}
	
	//////////////////////////// occupation ///////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_dndt_scale dat1281_numerical_entropy_avg_interp_scaled vs dat1281_cs_cleaned_avg_occ_interp;  
//	AppendToGraph /W=paper_figure_dndt_scale dat1282_numerical_entropy_avg_interp_scaled vs dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_dndt_scale dat1283_numerical_entropy_avg_interp_scaled vs dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_dndt_scale dat1284_numerical_entropy_avg_interp_scaled vs dat1284_cs_cleaned_avg_occ_interp;  
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_dndt_scale fit_dat1281_numerical_entropy_avg_interp_scaled vs fit_dat1281_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_dndt_scale fit_dat1282_numerical_entropy_avg_interp_scaled vs fit_dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_dndt_scale fit_dat1283_numerical_entropy_avg_interp_scaled vs fit_dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_dndt_scale fit_dat1284_numerical_entropy_avg_interp_scaled vs fit_dat1284_cs_cleaned_avg_occ_interp;
//	
//	Label /W=paper_figure_dndt_scale bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1281_numerical_entropy_avg_interp_scaled)=2, lsize(dat1281_numerical_entropy_avg_interp_scaled)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1282_numerical_entropy_avg_interp_scaled)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1283_numerical_entropy_avg_interp_scaled)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1284_numerical_entropy_avg_interp_scaled)=2, lsize(dat1284_numerical_entropy_avg_interp_scaled)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
	
	// modify fits
	ModifyGraph /W=paper_figure_dndt_scale mode(fit_dat1281_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1281_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_dndt_scale mode(fit_dat1282_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1282_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_dndt_scale mode(fit_dat1283_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1283_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_dndt_scale mode(fit_dat1284_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
		
	
	Label /W=paper_figure_dndt_scale left "dN/dT (.arb)"
	
	Legend/W=paper_figure_dndt_scale /C/N=text0/J/F=0 "\\s(fit_dat1281_numerical_entropy_avg_interp_scaled) Γ/T = 0.9\r\\s(fit_dat1282_numerical_entropy_avg_interp_scaled) Γ/T = 8.8\r\\s(fit_dat1283_numerical_entropy_avg_interp_scaled) Γ/T = 21.7\r\\s(fit_dat1284_numerical_entropy_avg_interp_scaled) Γ/T = 30.9"

	
	beautify_figure("paper_figure_dndt_scale")
	
	
		///// append data
	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
	
	///// append fits
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_dndt_scale /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled
	
	
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1281_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1281_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1281_numerical_entropy_avg_interp_noscaled)=(0,0,0)
//	ModifyGraph /W=paper_figure_dndt_scale mode(dat1282_numerical_entropy_avg_interp_scaled)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_dndt_scale mode(dat1283_numerical_entropy_avg_interp_scaled)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_dndt_scale mode(dat1284_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1284_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1284_numerical_entropy_avg_interp_noscaled)=(47802,0,2056)
	
//	ModifyGraph /W=paper_figure_dndt_scale  axisEnab(l1)={0.5,0.9},axisEnab(b1)={0.1,0.4},freePos(l1)={-25,b1},freePos(b1)={-0.0021,l1}
	ModifyGraph /W=paper_figure_dndt_scale nticks(l1)=2, nticks(b1)=2, noLabel(b1)=0, axisEnab(l1)={0.5,0.9}, axisEnab(b1)={0.1,0.4}, freePos(l1)={-25,b1}, freePos(b1)={-0.0015,l1}
	
	
	ModifyGraph /W=paper_figure_dndt_scale  mirror=0,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph/W=paper_figure_dndt_scale muloffset={0.005,0}
	
endmacro



macro paper_v1_figure_4()
// entropy 6081 6080 6079 

	Display; KillWindow /Z paper_figure_4; DoWindow/C/O paper_figure_4 
	
	// if cond global fit
	// cond :: dat6081_dot_cleaned_avg_interp
	// cond fit :: GFit_dat6081_dot_cleaned_avg_interp
	// occ :: dat6081_cs_cleaned_avg_occ_interp
	// occ fit :: fit_dat6081_cs_cleaned_avg_occ_interp
	
	// if CT global fit
	// cond :: dat6081_dot_cleaned_avg_interp
	// cond fit :: fit_dat6081_dot_cleaned_avg_interp
	// occ :: dat6081_cs_cleaned_avg_occ_interp
	// occ fit :: GFit_dat6081_cs_cleaned_avg_occ_interp

	
//	/////// sweepgate //////
//	///// append data
//	AppendToGraph /W=paper_figure_4 dat6081_dot_cleaned_avg_interp
//	AppendToGraph /W=paper_figure_4 dat6080_dot_cleaned_avg_interp
//	AppendToGraph /W=paper_figure_4 dat6079_dot_cleaned_avg_interp
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_4 GFit_dat6081_dot_cleaned_avg_interp
//	AppendToGraph /W=paper_figure_4 GFit_dat6080_dot_cleaned_avg_interp
//	AppendToGraph /W=paper_figure_4 GFit_dat6079_dot_cleaned_avg_interp
//	
//	Label /W=paper_figure_4 bottom "Sweepgate (mV)"

	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4 dat6081_dot_cleaned_avg_interp vs dat6081_cs_cleaned_avg_occ_interp
	AppendToGraph /W=paper_figure_4 dat6080_dot_cleaned_avg_interp vs dat6080_cs_cleaned_avg_occ_interp
	AppendToGraph /W=paper_figure_4 dat6079_dot_cleaned_avg_interp vs dat6079_cs_cleaned_avg_occ_interp
//	
//	///// append fits
	AppendToGraph /W=paper_figure_4 GFit_dat6081_dot_cleaned_avg_interp vs fit_dat6081_cs_cleaned_avg_occ_interp
	AppendToGraph /W=paper_figure_4 GFit_dat6080_dot_cleaned_avg_interp vs fit_dat6080_cs_cleaned_avg_occ_interp
	AppendToGraph /W=paper_figure_4 GFit_dat6079_dot_cleaned_avg_interp vs fit_dat6079_cs_cleaned_avg_occ_interp
	
	Label /W=paper_figure_4 bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_4 mode(dat6081_dot_cleaned_avg_interp)=2, lsize(dat6081_dot_cleaned_avg_interp)=1, rgb(dat6081_dot_cleaned_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_4 mode(dat6080_dot_cleaned_avg_interp)=2, lsize(dat6080_dot_cleaned_avg_interp)=1, rgb(dat6080_dot_cleaned_avg_interp)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4 mode(dat6079_dot_cleaned_avg_interp)=2, lsize(dat6079_dot_cleaned_avg_interp)=1, rgb(dat6079_dot_cleaned_avg_interp)=(52685,33924,12336)
	
	// modify fits
	ModifyGraph /W=paper_figure_4 mode(GFit_dat6081_dot_cleaned_avg_interp)=0, lsize(GFit_dat6081_dot_cleaned_avg_interp)=2, rgb(GFit_dat6081_dot_cleaned_avg_interp)=(0,0,0)
	ModifyGraph /W=paper_figure_4 mode(GFit_dat6080_dot_cleaned_avg_interp)=0, lsize(GFit_dat6080_dot_cleaned_avg_interp)=2, rgb(GFit_dat6080_dot_cleaned_avg_interp)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4 mode(GFit_dat6079_dot_cleaned_avg_interp)=0, lsize(GFit_dat6079_dot_cleaned_avg_interp)=2, rgb(GFit_dat6079_dot_cleaned_avg_interp)=(52685,33924,12336)
		
	
	Label /W=paper_figure_4 left "Conductance (\\$WMTEX$ 2e^2/h \\$/WMTEX$)"
	
	Legend/W=paper_figure_4 /C/N=text0/J/F=0 "\\s(GFit_dat6081_dot_cleaned_avg_interp) Γ/T = 1.0\r\\s(GFit_dat6080_dot_cleaned_avg_interp) Γ/T = 9.5\r\\s(GFit_dat6079_dot_cleaned_avg_interp) Γ/T = 24.3"

	beautify_figure("paper_figure_4")

endmacro





macro paper_v2_figure_2a_strong()
// data from summer cool down
//Temp	 22.5 100  300  500
//Datnum 6079 6088 6085 6082


// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_2a; DoWindow/C/O paper_figure_2a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_cs_cleaned_avg dat6079_cs_cleaned_avg_scale
	duplicate /o dat6088_cs_cleaned_avg dat6088_cs_cleaned_avg_scale
	duplicate /o dat6085_cs_cleaned_avg dat6085_cs_cleaned_avg_scale
	duplicate /o dat6082_cs_cleaned_avg dat6082_cs_cleaned_avg_scale
	
	duplicate /o fit_dat6079_cs_cleaned_avg fit_dat6079_cs_cleaned_avg_scale
	duplicate /o fit_dat6088_cs_cleaned_avg fit_dat6088_cs_cleaned_avg_scale
	duplicate /o fit_dat6085_cs_cleaned_avg fit_dat6085_cs_cleaned_avg_scale
	duplicate /o fit_dat6082_cs_cleaned_avg fit_dat6082_cs_cleaned_avg_scale
	
	
	////////// removing linear and quadratic terms /////
	// data
	create_x_wave(dat6079_cs_cleaned_avg_scale)
	dat6079_cs_cleaned_avg_scale -= (coef_dat6079_cs_cleaned_avg[5]*x_wave[p] + coef_dat6079_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6079_cs_cleaned_avg[2], x_wave[inf]-coef_dat6079_cs_cleaned_avg[2], dat6079_cs_cleaned_avg_scale

	create_x_wave(dat6088_cs_cleaned_avg_scale)
	dat6088_cs_cleaned_avg_scale -= (coef_dat6088_cs_cleaned_avg[5]*x_wave[p] + coef_dat6088_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6088_cs_cleaned_avg[2], x_wave[inf]-coef_dat6088_cs_cleaned_avg[2], dat6088_cs_cleaned_avg_scale
	
	create_x_wave(dat6085_cs_cleaned_avg_scale)
	dat6085_cs_cleaned_avg_scale -= (coef_dat6085_cs_cleaned_avg[5]*x_wave[p] + coef_dat6085_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6085_cs_cleaned_avg[2], x_wave[inf]-coef_dat6085_cs_cleaned_avg[2], dat6085_cs_cleaned_avg_scale
	
	create_x_wave(dat6082_cs_cleaned_avg_scale)
	dat6082_cs_cleaned_avg_scale -= (coef_dat6082_cs_cleaned_avg[5]*x_wave[p] + coef_dat6082_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6082_cs_cleaned_avg[2], x_wave[inf]-coef_dat6082_cs_cleaned_avg[2], dat6082_cs_cleaned_avg_scale
	
	// fit
	create_x_wave(fit_dat6079_cs_cleaned_avg_scale)
	fit_dat6079_cs_cleaned_avg_scale -= (coef_dat6079_cs_cleaned_avg[5]*x_wave[p] + coef_dat6079_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6079_cs_cleaned_avg[2], x_wave[inf]-coef_dat6079_cs_cleaned_avg[2], fit_dat6079_cs_cleaned_avg_scale
	
	create_x_wave(fit_dat6088_cs_cleaned_avg_scale)
	fit_dat6088_cs_cleaned_avg_scale -= (coef_dat6088_cs_cleaned_avg[5]*x_wave[p] + coef_dat6088_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6088_cs_cleaned_avg[2], x_wave[inf]-coef_dat6088_cs_cleaned_avg[2], fit_dat6088_cs_cleaned_avg_scale
	
	create_x_wave(fit_dat6085_cs_cleaned_avg_scale)
	fit_dat6085_cs_cleaned_avg_scale -= (coef_dat6085_cs_cleaned_avg[5]*x_wave[p] + coef_dat6085_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6085_cs_cleaned_avg[2], x_wave[inf]-coef_dat6085_cs_cleaned_avg[2], fit_dat6085_cs_cleaned_avg_scale
	
	create_x_wave(fit_dat6082_cs_cleaned_avg_scale)
	fit_dat6082_cs_cleaned_avg_scale -= (coef_dat6082_cs_cleaned_avg[5]*x_wave[p] + coef_dat6082_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6082_cs_cleaned_avg[2], x_wave[inf]-coef_dat6082_cs_cleaned_avg[2], fit_dat6082_cs_cleaned_avg_scale
	
	
//	// offset everything
//	variable offset = 0.003
//	dat6079_cs_cleaned_avg_scale += offset * 0
//	dat6088_cs_cleaned_avg_scale += offset * 1
//	dat6085_cs_cleaned_avg_scale += offset * 2
//	dat6082_cs_cleaned_avg_scale += offset * 3
//	
//	fit_dat6079_cs_cleaned_avg_scale += offset * 0
//	fit_dat6088_cs_cleaned_avg_scale += offset * 1
//	fit_dat6085_cs_cleaned_avg_scale += offset * 2
//	fit_dat6082_cs_cleaned_avg_scale += offset * 3
	
	
	/////// charge transition //////
	///// append data
	AppendToGraph /W=paper_figure_2a dat6079_cs_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2a dat6088_cs_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2a dat6085_cs_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2a dat6082_cs_cleaned_avg_scale; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2a fit_dat6079_cs_cleaned_avg_scale;
	AppendToGraph /W=paper_figure_2a fit_dat6088_cs_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2a fit_dat6085_cs_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2a fit_dat6082_cs_cleaned_avg_scale;
	
	// offset 
	variable offset = 0.0015
	variable const_offset = coef_dat6082_cs_cleaned_avg[4]
	ModifyGraph /W=paper_figure_2a offset(dat6079_cs_cleaned_avg_scale)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6088_cs_cleaned_avg_scale)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6085_cs_cleaned_avg_scale)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6082_cs_cleaned_avg_scale)={0,offset * 3 + const_offset}
	
	ModifyGraph /W=paper_figure_2a offset(fit_dat6079_cs_cleaned_avg_scale)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6088_cs_cleaned_avg_scale)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6085_cs_cleaned_avg_scale)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6082_cs_cleaned_avg_scale)={0,offset * 3 + const_offset}
	
	// modify data
	ModifyGraph /W=paper_figure_2a mode(dat6079_cs_cleaned_avg_scale)=2, lsize(dat6079_cs_cleaned_avg_scale)=1, rgb(dat6079_cs_cleaned_avg_scale)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(dat6088_cs_cleaned_avg_scale)=2, lsize(dat6088_cs_cleaned_avg_scale)=1, rgb(dat6088_cs_cleaned_avg_scale)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(dat6085_cs_cleaned_avg_scale)=2, lsize(dat6085_cs_cleaned_avg_scale)=1, rgb(dat6085_cs_cleaned_avg_scale)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(dat6082_cs_cleaned_avg_scale)=2, lsize(dat6082_cs_cleaned_avg_scale)=1, rgb(dat6082_cs_cleaned_avg_scale)=(65535,0,0)
	
	// modify fits
	ModifyGraph /W=paper_figure_2a mode(fit_dat6079_cs_cleaned_avg_scale)=0, lsize(fit_dat6079_cs_cleaned_avg_scale)=2, rgb(fit_dat6079_cs_cleaned_avg_scale)=(0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6088_cs_cleaned_avg_scale)=0, lsize(fit_dat6088_cs_cleaned_avg_scale)=2, rgb(fit_dat6088_cs_cleaned_avg_scale)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6085_cs_cleaned_avg_scale)=0, lsize(fit_dat6085_cs_cleaned_avg_scale)=2, rgb(fit_dat6085_cs_cleaned_avg_scale)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6082_cs_cleaned_avg_scale)=0, lsize(fit_dat6082_cs_cleaned_avg_scale)=2, rgb(fit_dat6082_cs_cleaned_avg_scale)=(65535,0,0)
	
	Label /W=paper_figure_2a left "Current (nA)"
	SetAxis /W=paper_figure_2a bottom -10,10
	
	Legend /W=paper_figure_2a /C/N=text0/J/F=0/F=0 "\\Zr080\\s(fit_dat6079_cs_cleaned_avg_scale) 22.5 mK\r\\s(fit_dat6088_cs_cleaned_avg_scale) 100 mK\r\\s(fit_dat6085_cs_cleaned_avg_scale) 300 mK\r\\s(fit_dat6082_cs_cleaned_avg_scale) 500 mK"
	
	
	//////////////////////////// occupation ///////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_2a dat6079_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat6088_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat6085_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a dat6082_cs_cleaned_avg_occ; 
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_2a fit_dat6079_cs_cleaned_avg_occ;
//	AppendToGraph /W=paper_figure_2a fit_dat6088_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a fit_dat6085_cs_cleaned_avg_occ; 
//	AppendToGraph /W=paper_figure_2a fit_dat6082_cs_cleaned_avg_occ;
//	
//	// modify data
//	ModifyGraph /W=paper_figure_2a mode(dat6079_cs_cleaned_avg_occ)=2, lsize(dat6079_cs_cleaned_avg_occ)=1, rgb(dat6079_cs_cleaned_avg_occ)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(dat6088_cs_cleaned_avg_occ)=2, lsize(dat6088_cs_cleaned_avg_occ)=1, rgb(dat6088_cs_cleaned_avg_occ)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(dat6085_cs_cleaned_avg_occ)=2, lsize(dat6085_cs_cleaned_avg_occ)=1, rgb(dat6085_cs_cleaned_avg_occ)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(dat6082_cs_cleaned_avg_occ)=2, lsize(dat6082_cs_cleaned_avg_occ)=1, rgb(dat6082_cs_cleaned_avg_occ)=(65535,0,0)
//	
//	// modify fits
//	ModifyGraph /W=paper_figure_2a mode(fit_dat6079_cs_cleaned_avg_occ)=0, lsize(fit_dat6079_cs_cleaned_avg_occ)=2, rgb(fit_dat6079_cs_cleaned_avg_occ)=(0,0,65535)
//	ModifyGraph /W=paper_figure_2a mode(fit_dat6088_cs_cleaned_avg_occ)=0, lsize(fit_dat6088_cs_cleaned_avg_occ)=2, rgb(fit_dat6088_cs_cleaned_avg_occ)=(29524,1,58982)
//	ModifyGraph /W=paper_figure_2a mode(fit_dat6085_cs_cleaned_avg_occ)=0, lsize(fit_dat6085_cs_cleaned_avg_occ)=2, rgb(fit_dat6085_cs_cleaned_avg_occ)=(64981,37624,14500)
//	ModifyGraph /W=paper_figure_2a mode(fit_dat6082_cs_cleaned_avg_occ)=0, lsize(fit_dat6082_cs_cleaned_avg_occ)=2, rgb(fit_dat6082_cs_cleaned_avg_occ)=(65535,0,0)
//	
//	Label /W=paper_figure_2a left "Occupation (.arb)"
//	
//	Legend /W=paper_figure_2a /C/N=text0/J/F=0 "\\s(fit_dat6079_cs_cleaned_avg_occ) 22.5 mK\r\\s(fit_dat6088_cs_cleaned_avg_occ) 90 mK\r\\s(fit_dat6085_cs_cleaned_avg_occ) 275 mK\r\\s(fit_dat6082_cs_cleaned_avg_occ) 400 mK"
	//////////////////////////////////////////////////////////////////////
	
	Label /W=paper_figure_2a bottom "Sweepgate  (mV)"
//	Label /W=paper_figure_2a bottom "Sweepgate (centered by mid) (mV)"
	ModifyGraph /W=paper_figure_2a muloffset={0.005,0}
	
	beautify_figure("paper_figure_2a")
	// dat1282_numerical_entropy_avg_interp vs dat1282_cs_cleaned_avg_occ_interp
// fit_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
// fit_nrg_dat1282_numerical_entropy_avg_interp vs fit_dat1282_cs_cleaned_avg_occ_interp
endmacro


macro paper_v2_figure_2b_strong()
// data from summer cool down
//Temp	 22.5 100  300  500
//Datnum 6079 6088 6085 6082


// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_2b; DoWindow/C/O paper_figure_2b 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale
	duplicate /o dat6088_dot_cleaned_avg_interp dat6088_dot_cleaned_avg_scale
	duplicate /o dat6085_dot_cleaned_avg_interp dat6085_dot_cleaned_avg_scale
	duplicate /o dat6082_dot_cleaned_avg_interp dat6082_dot_cleaned_avg_scale
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale
	duplicate /o gfit_dat6088_dot_cleaned_avg_interp gfit_dat6088_dot_cleaned_avg_scale
	duplicate /o gfit_dat6085_dot_cleaned_avg_interp gfit_dat6085_dot_cleaned_avg_scale
	duplicate /o gfit_dat6082_dot_cleaned_avg_interp gfit_dat6082_dot_cleaned_avg_scale
	
	
	////////// removing linear and quadratic terms /////
//	// data
//	create_x_wave(dat6079_dot_cleaned_avg_scale)
//	dat6079_dot_cleaned_avg_scale -= (coef_dat6079_dot_cleaned_avg[5]*x_wave[p] + coef_dat6079_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6079_dot_cleaned_avg[2], x_wave[inf]-coef_dat6079_dot_cleaned_avg[2], dat6079_dot_cleaned_avg_scale
//
//	create_x_wave(dat6088_dot_cleaned_avg_scale)
//	dat6088_dot_cleaned_avg_scale -= (coef_dat6088_dot_cleaned_avg[5]*x_wave[p] + coef_dat6088_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6088_dot_cleaned_avg[2], x_wave[inf]-coef_dat6088_dot_cleaned_avg[2], dat6088_dot_cleaned_avg_scale
//	
//	create_x_wave(dat6085_dot_cleaned_avg_scale)
//	dat6085_dot_cleaned_avg_scale -= (coef_dat6085_dot_cleaned_avg[5]*x_wave[p] + coef_dat6085_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6085_dot_cleaned_avg[2], x_wave[inf]-coef_dat6085_dot_cleaned_avg[2], dat6085_dot_cleaned_avg_scale
//	
//	create_x_wave(dat6082_dot_cleaned_avg_scale)
//	dat6082_dot_cleaned_avg_scale -= (coef_dat6082_dot_cleaned_avg[5]*x_wave[p] + coef_dat6082_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6082_dot_cleaned_avg[2], x_wave[inf]-coef_dat6082_dot_cleaned_avg[2], dat6082_dot_cleaned_avg_scale
//	
//	// gfit
//	create_x_wave(gfit_dat6079_dot_cleaned_avg_scale)
//	gfit_dat6079_dot_cleaned_avg_scale -= (coef_dat6079_dot_cleaned_avg[5]*x_wave[p] + coef_dat6079_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6079_dot_cleaned_avg[2], x_wave[inf]-coef_dat6079_dot_cleaned_avg[2], gfit_dat6079_dot_cleaned_avg_scale
//	
//	create_x_wave(gfit_dat6088_dot_cleaned_avg_scale)
//	gfit_dat6088_dot_cleaned_avg_scale -= (coef_dat6088_dot_cleaned_avg[5]*x_wave[p] + coef_dat6088_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6088_dot_cleaned_avg[2], x_wave[inf]-coef_dat6088_dot_cleaned_avg[2], gfit_dat6088_dot_cleaned_avg_scale
//	
//	create_x_wave(gfit_dat6085_dot_cleaned_avg_scale)
//	gfit_dat6085_dot_cleaned_avg_scale -= (coef_dat6085_dot_cleaned_avg[5]*x_wave[p] + coef_dat6085_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_dot_cleaned_avg[4]
////	setscale /I x x_wave[0]-coef_dat6085_dot_cleaned_avg[2], x_wave[inf]-coef_dat6085_dot_cleaned_avg[2], gfit_dat6085_dot_cleaned_avg_scale
//	
//	create_x_wave(gfit_dat6082_dot_cleaned_avg_scale)
//	gfit_dat6082_dot_cleaned_avg_scale -= (coef_dat6082_dot_cleaned_avg[5]*x_wave[p] + coef_dat6082_dot_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_dot_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6082_dot_cleaned_avg[2], x_wave[inf]-coef_dat6082_dot_cleaned_avg[2], gfit_dat6082_dot_cleaned_avg_scale
	
	/////// charge transition //////
	
//		///// translate data
//	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale, dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6088_dot_cleaned_avg_scale, dat6088_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6085_dot_cleaned_avg_scale, dat6085_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6082_dot_cleaned_avg_scale, dat6082_cs_cleaned_avg_occ_interp) 
//
//	///// translate fit
//	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale, fit_dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6088_dot_cleaned_avg_scale, fit_dat6088_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6085_dot_cleaned_avg_scale, fit_dat6085_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6082_dot_cleaned_avg_scale, fit_dat6082_cs_cleaned_avg_occ_interp)  
	
//	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_2b dat6079_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2b dat6088_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2b dat6085_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2b dat6082_dot_cleaned_avg_scale; 
	
	///// append gfits
	AppendToGraph /W=paper_figure_2b gfit_dat6079_dot_cleaned_avg_scale;
	AppendToGraph /W=paper_figure_2b gfit_dat6088_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2b gfit_dat6085_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_2b gfit_dat6082_dot_cleaned_avg_scale;
	Label /W=paper_figure_2b bottom "Sweepgate  (mV)"
//	////////////////////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_2b dat6079_dot_cleaned_avg_scale vs dat6079_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_2b dat6088_dot_cleaned_avg_scale vs dat6088_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_2b dat6085_dot_cleaned_avg_scale vs dat6085_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_2b dat6082_dot_cleaned_avg_scale vs dat6082_cs_cleaned_avg_occ_interp; 
//	
//	///// append gfits
//	AppendToGraph /W=paper_figure_2b gfit_dat6079_dot_cleaned_avg_scale vs fit_dat6079_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_2b gfit_dat6088_dot_cleaned_avg_scale vs fit_dat6088_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_2b gfit_dat6085_dot_cleaned_avg_scale vs fit_dat6085_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_2b gfit_dat6082_dot_cleaned_avg_scale vs fit_dat6082_cs_cleaned_avg_occ_interp;
//	Label /W=paper_figure_2b bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// modify data
	ModifyGraph /W=paper_figure_2b mode(dat6079_dot_cleaned_avg_scale)=2, lsize(dat6079_dot_cleaned_avg_scale)=1, rgb(dat6079_dot_cleaned_avg_scale)=(0,0,65535)
	ModifyGraph /W=paper_figure_2b mode(dat6088_dot_cleaned_avg_scale)=2, lsize(dat6088_dot_cleaned_avg_scale)=1, rgb(dat6088_dot_cleaned_avg_scale)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2b mode(dat6085_dot_cleaned_avg_scale)=2, lsize(dat6085_dot_cleaned_avg_scale)=1, rgb(dat6085_dot_cleaned_avg_scale)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2b mode(dat6082_dot_cleaned_avg_scale)=2, lsize(dat6082_dot_cleaned_avg_scale)=1, rgb(dat6082_dot_cleaned_avg_scale)=(65535,0,0)
	
	// modify gfits
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6079_dot_cleaned_avg_scale)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale)=2, rgb(gfit_dat6079_dot_cleaned_avg_scale)=(0,0,65535)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6088_dot_cleaned_avg_scale)=0, lsize(gfit_dat6088_dot_cleaned_avg_scale)=2, rgb(gfit_dat6088_dot_cleaned_avg_scale)=(29524,1,58982)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6085_dot_cleaned_avg_scale)=0, lsize(gfit_dat6085_dot_cleaned_avg_scale)=2, rgb(gfit_dat6085_dot_cleaned_avg_scale)=(64981,37624,14500)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6082_dot_cleaned_avg_scale)=0, lsize(gfit_dat6082_dot_cleaned_avg_scale)=2, rgb(gfit_dat6082_dot_cleaned_avg_scale)=(65535,0,0)
	
	Label /W=paper_figure_2b left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Legend /W=paper_figure_2b /C/N=text0/J/F=0 "\\s(gfit_dat6079_dot_cleaned_avg_scale) 22.5 mK\r\\s(gfit_dat6088_dot_cleaned_avg_scale) 100 mK\r\\s(gfit_dat6085_dot_cleaned_avg_scale) 300 mK\r\\s(gfit_dat6082_dot_cleaned_avg_scale) 500 mK"
//	/A=LT/X=4.50/Y=5.26
//	Label /W=paper_figure_2b bottom "Sweepgate (centered by mid) (mV)"
	
//	ModifyGraph /W=paper_figure_2b muloffset={0.005,0}
	SetAxis /W=paper_figure_2b bottom -10,10
	ModifyGraph /W=paper_figure_2b muloffset={0.005,0}
	
	beautify_figure("paper_figure_2b")

endmacro


//macro paper_v2_figure_3_layout()
//	NewLayout/W=(663,53,1691,903)
////	LayoutPageAction size(-1)=(288, 720), margins(-1)=(18, 18, 18, 18)
//endmacro

macro paper_v2_figure_3a()
// data from summer cool down
// base temp
//Datnum 6079 6080 6081


	Display; KillWindow /Z paper_figure_3a; DoWindow/C/O paper_figure_3a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale
	duplicate /o dat6080_dot_cleaned_avg_interp dat6080_dot_cleaned_avg_scale
	duplicate /o dat6081_dot_cleaned_avg_interp dat6081_dot_cleaned_avg_scale
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale
	duplicate /o gfit_dat6080_dot_cleaned_avg_interp gfit_dat6080_dot_cleaned_avg_scale
	duplicate /o gfit_dat6081_dot_cleaned_avg_interp gfit_dat6081_dot_cleaned_avg_scale
	
	
	
	/////// charge transition //////
	
	
	
	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
//		///// translate data
	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale, dat6079_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat6080_dot_cleaned_avg_scale, dat6080_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat6081_dot_cleaned_avg_scale, dat6081_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale, fit_dat6079_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(gfit_dat6080_dot_cleaned_avg_scale, fit_dat6080_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(gfit_dat6081_dot_cleaned_avg_scale, fit_dat6081_cs_cleaned_avg_occ_interp) 

	///// append data
	AppendToGraph /W=paper_figure_3a dat6079_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_3a dat6080_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_3a dat6081_dot_cleaned_avg_scale; 
	
	///// append gfits
	AppendToGraph /W=paper_figure_3a gfit_dat6079_dot_cleaned_avg_scale;
	AppendToGraph /W=paper_figure_3a gfit_dat6080_dot_cleaned_avg_scale; 
	AppendToGraph /W=paper_figure_3a gfit_dat6081_dot_cleaned_avg_scale; 
	Label /W=paper_figure_3a bottom "Sweepgate  (mV)"
	ModifyGraph /W=paper_figure_3a muloffset={0.005,0}
//	////////////////////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_3a dat6079_dot_cleaned_avg_scale vs dat6079_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a dat6080_dot_cleaned_avg_scale vs dat6080_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a dat6081_dot_cleaned_avg_scale vs dat6081_cs_cleaned_avg_occ_interp; 
//	
//	///// append gfits
//	AppendToGraph /W=paper_figure_3a gfit_dat6079_dot_cleaned_avg_scale vs fit_dat6079_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_3a gfit_dat6080_dot_cleaned_avg_scale vs fit_dat6080_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a gfit_dat6081_dot_cleaned_avg_scale vs fit_dat6081_cs_cleaned_avg_occ_interp; 
//	Label /W=paper_figure_3a bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_3a mode(dat6079_dot_cleaned_avg_scale)=2, lsize(dat6079_dot_cleaned_avg_scale)=1, rgb(dat6079_dot_cleaned_avg_scale)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_3a mode(dat6080_dot_cleaned_avg_scale)=2, lsize(dat6080_dot_cleaned_avg_scale)=1, rgb(dat6080_dot_cleaned_avg_scale)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_3a mode(dat6081_dot_cleaned_avg_scale)=2, lsize(dat6081_dot_cleaned_avg_scale)=1, rgb(dat6081_dot_cleaned_avg_scale)=(0,0,0)
	
	// modify gfits
	ModifyGraph /W=paper_figure_3a mode(gfit_dat6079_dot_cleaned_avg_scale)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale)=2, rgb(gfit_dat6079_dot_cleaned_avg_scale)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_3a mode(gfit_dat6080_dot_cleaned_avg_scale)=0, lsize(gfit_dat6080_dot_cleaned_avg_scale)=2, rgb(gfit_dat6080_dot_cleaned_avg_scale)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_3a mode(gfit_dat6081_dot_cleaned_avg_scale)=0, lsize(gfit_dat6081_dot_cleaned_avg_scale)=2, rgb(gfit_dat6081_dot_cleaned_avg_scale)=(0,0,0)
	
	Label /W=paper_figure_3a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Legend /W=paper_figure_3a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale) Γ/T = 24.29\r\\s(gfit_dat6080_dot_cleaned_avg_scale) Γ/T = 9.48\r\\s(gfit_dat6081_dot_cleaned_avg_scale) Γ/T = 0.99"
	
//	Label /W=paper_figure_3a bottom "Sweepgate (centered by mid) (mV)"
	
//	ModifyGraph /W=paper_figure_3a muloffset={0.005,0}
	SetAxis /W=paper_figure_3a bottom -8,8
	beautify_figure("paper_figure_3a")

endmacro



macro paper_v2_figure_3b()
// entropy 1281 1282 1283 1284

	Display; KillWindow /Z paper_figure_3b; DoWindow/C/O paper_figure_3b 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled
	
	///// non-scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_noscaled
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_noscaled
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_noscaled
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_noscaled
	
	// offset to 0
	dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	fit_dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	fit_dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	fit_dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	// scale everything by the maximum fit value
	dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	fit_dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	fit_dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	fit_dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	fit_dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
//	// offset everything
//	variable offset = 0
//	dat1281_numerical_entropy_avg_interp_scaled += offset * 0
//	dat1282_numerical_entropy_avg_interp_scaled += offset * 1
//	dat1283_numerical_entropy_avg_interp_scaled += offset * 2
//	dat1284_numerical_entropy_avg_interp_scaled += offset * 3
//	
//	fit_dat1281_numerical_entropy_avg_interp_scaled += offset * 0
//	fit_dat1282_numerical_entropy_avg_interp_scaled += offset * 1
//	fit_dat1283_numerical_entropy_avg_interp_scaled += offset * 2
//	fit_dat1284_numerical_entropy_avg_interp_scaled += offset * 3
	
	
//	resampleWave(dat1281_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1282_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1283_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1284_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
	
	smooth 1000, dat1281_numerical_entropy_avg_interp_scaled
	smooth 1000, dat1282_numerical_entropy_avg_interp_scaled
	smooth 1000, dat1283_numerical_entropy_avg_interp_scaled
	smooth 2000, dat1284_numerical_entropy_avg_interp_scaled
	
	////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	
//	/////// sweepgate //////
	///// translate data
	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_scaled, dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_scaled, dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_scaled, dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_scaled, dat1284_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_scaled, fit_dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_scaled, fit_dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_scaled, fit_dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_scaled, fit_dat1284_cs_cleaned_avg_occ_interp) 
	///// append data
	AppendToGraph /W=paper_figure_3b dat1281_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b dat1282_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b dat1283_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b dat1284_numerical_entropy_avg_interp_scaled
	
	///// append fits
	AppendToGraph /W=paper_figure_3b fit_dat1281_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b fit_dat1282_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b fit_dat1283_numerical_entropy_avg_interp_scaled
	AppendToGraph /W=paper_figure_3b fit_dat1284_numerical_entropy_avg_interp_scaled
	
	Label /W=paper_figure_3b bottom "Sweepgate (mV)"
	
	
	// offset 
	variable offset = 1
	variable const_offset = 0
	ModifyGraph /W=paper_figure_3b offset(dat1281_numerical_entropy_avg_interp_scaled)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1282_numerical_entropy_avg_interp_scaled)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1283_numerical_entropy_avg_interp_scaled)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1284_numerical_entropy_avg_interp_scaled)={0,offset * 3 + const_offset}
	
	ModifyGraph /W=paper_figure_3b offset(fit_dat1281_numerical_entropy_avg_interp_scaled)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(fit_dat1282_numerical_entropy_avg_interp_scaled)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(fit_dat1283_numerical_entropy_avg_interp_scaled)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(fit_dat1284_numerical_entropy_avg_interp_scaled)={0,offset * 3 + const_offset}
	
	
	
	///// adding inset
	///// translate data
	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_noscaled, dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_noscaled, dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_noscaled, dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_noscaled, dat1284_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_noscaled, fit_dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_noscaled, fit_dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_noscaled, fit_dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_noscaled, fit_dat1284_cs_cleaned_avg_occ_interp) 

//	///// append data
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled
//	
//	ModifyGraph /W=paper_figure_3b  axisEnab(l1)={0.5,0.9},axisEnab(b1)={0.1,0.4},freePos(l1)={-25,b1},freePos(b1)={-0.0021,l1}
	
	//////////////////////////// occupation ///////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_3b dat1281_numerical_entropy_avg_interp_scaled vs dat1281_cs_cleaned_avg_occ_interp;  
//	AppendToGraph /W=paper_figure_3b dat1282_numerical_entropy_avg_interp_scaled vs dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b dat1283_numerical_entropy_avg_interp_scaled vs dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b dat1284_numerical_entropy_avg_interp_scaled vs dat1284_cs_cleaned_avg_occ_interp;  
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_3b fit_dat1281_numerical_entropy_avg_interp_scaled vs fit_dat1281_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_3b fit_dat1282_numerical_entropy_avg_interp_scaled vs fit_dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b fit_dat1283_numerical_entropy_avg_interp_scaled vs fit_dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b fit_dat1284_numerical_entropy_avg_interp_scaled vs fit_dat1284_cs_cleaned_avg_occ_interp;
//	
//	Label /W=paper_figure_3b bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_3b mode(dat1281_numerical_entropy_avg_interp_scaled)=2, lsize(dat1281_numerical_entropy_avg_interp_scaled)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_3b mode(dat1282_numerical_entropy_avg_interp_scaled)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_3b mode(dat1283_numerical_entropy_avg_interp_scaled)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_3b mode(dat1284_numerical_entropy_avg_interp_scaled)=2, lsize(dat1284_numerical_entropy_avg_interp_scaled)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
	
	// modify fits
	ModifyGraph /W=paper_figure_3b mode(fit_dat1281_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1281_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_3b mode(fit_dat1282_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1282_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_3b mode(fit_dat1283_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1283_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_3b mode(fit_dat1284_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
		
	
	Label /W=paper_figure_3b left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_3b")
	
	
		///// append data
	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
	
	///// append fits
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled
	
	
	ModifyGraph /W=paper_figure_3b mode(dat1281_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1281_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1281_numerical_entropy_avg_interp_noscaled)=(0,0,0)
//	ModifyGraph /W=paper_figure_3b mode(dat1282_numerical_entropy_avg_interp_scaled)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_3b mode(dat1283_numerical_entropy_avg_interp_scaled)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_3b mode(dat1284_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1284_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1284_numerical_entropy_avg_interp_noscaled)=(47802,0,2056)
	
//	ModifyGraph /W=paper_figure_3b  axisEnab(l1)={0.5,0.9},axisEnab(b1)={0.1,0.4},freePos(l1)={-25,b1},freePos(b1)={-0.0021,l1}
//	ModifyGraph /W=paper_figure_3b nticks(l1)=2, nticks(b1)=2, noLabel(l1)=2, axisEnab(l1)={0.58,0.98}, axisEnab(b1)={0.03,0.33}, freePos(l1)={-25,b1}, freePos(b1)={-0.0015,l1}
	ModifyGraph /W=paper_figure_3b nticks(l1)=2, nticks(b1)=2, noLabel(l1)=2, axisEnab(l1)={0.15,0.55}, axisEnab(b1)={0.03,0.33}, freePos(l1)={-25,b1}, freePos(b1)={-0.0015,l1}

	
	Legend/W=paper_figure_3b /C/N=text0/J/F=0/A=RB/X=4.50/Y=69.35 "\\Zr080\\s(fit_dat1281_numerical_entropy_avg_interp_scaled) Γ/T = 0.9\r\\s(fit_dat1282_numerical_entropy_avg_interp_scaled) Γ/T = 8.8\r\\s(fit_dat1283_numerical_entropy_avg_interp_scaled) Γ/T = 21.7\r\\s(fit_dat1284_numerical_entropy_avg_interp_scaled) Γ/T = 30.9"

	ModifyGraph /W=paper_figure_3b  mirror=0,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=8, tick=2, gFont="Calibri", gfSize=8
	ModifyGraph/W=paper_figure_3b muloffset={0.005,0}
	SetAxis /W=paper_figure_3b bottom -10,10
	
	ModifyGraph /W=paper_figure_3b mirror(left)=1,mirror(bottom)=1
//	SetAxis /W=paper_figure_3b bottom -6,9
	
endmacro




macro paper_v2_figure_4a()
// data from summer cool down
// base temp
//Datnum 6079 6080 6081


	Display; KillWindow /Z paper_figure_4a; DoWindow/C/O paper_figure_4a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale
	duplicate /o dat6080_dot_cleaned_avg_interp dat6080_dot_cleaned_avg_scale
	duplicate /o dat6081_dot_cleaned_avg_interp dat6081_dot_cleaned_avg_scale
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale
	duplicate /o gfit_dat6080_dot_cleaned_avg_interp gfit_dat6080_dot_cleaned_avg_scale
	duplicate /o gfit_dat6081_dot_cleaned_avg_interp gfit_dat6081_dot_cleaned_avg_scale
	
	
	
	/////// charge transition //////
	
	
	
	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
////		///// translate data
//	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale, dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6080_dot_cleaned_avg_scale, dat6080_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6081_dot_cleaned_avg_scale, dat6081_cs_cleaned_avg_occ_interp) 
//
//	///// translate fit
//	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale, fit_dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6080_dot_cleaned_avg_scale, fit_dat6080_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6081_dot_cleaned_avg_scale, fit_dat6081_cs_cleaned_avg_occ_interp) 
//
//	///// append data
//	AppendToGraph /W=paper_figure_4a dat6079_dot_cleaned_avg_scale; 
//	AppendToGraph /W=paper_figure_4a dat6080_dot_cleaned_avg_scale; 
//	AppendToGraph /W=paper_figure_4a dat6081_dot_cleaned_avg_scale; 
//	
//	///// append gfits
//	AppendToGraph /W=paper_figure_4a gfit_dat6079_dot_cleaned_avg_scale;
//	AppendToGraph /W=paper_figure_4a gfit_dat6080_dot_cleaned_avg_scale; 
//	AppendToGraph /W=paper_figure_4a gfit_dat6081_dot_cleaned_avg_scale; 
//	Label /W=paper_figure_4a bottom "Sweepgate  (mV)"
//	ModifyGraph /W=paper_figure_4a muloffset={0.005,0}
//	////////////////////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4a dat6079_dot_cleaned_avg_scale vs dat6079_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a dat6080_dot_cleaned_avg_scale vs dat6080_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a dat6081_dot_cleaned_avg_scale vs dat6081_cs_cleaned_avg_occ_interp; 
	
	///// append gfits
	AppendToGraph /W=paper_figure_4a gfit_dat6079_dot_cleaned_avg_scale vs fit_dat6079_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4a gfit_dat6080_dot_cleaned_avg_scale vs fit_dat6080_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a gfit_dat6081_dot_cleaned_avg_scale vs fit_dat6081_cs_cleaned_avg_occ_interp; 
	Label /W=paper_figure_4a bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_4a mode(dat6079_dot_cleaned_avg_scale)=2, lsize(dat6079_dot_cleaned_avg_scale)=1, rgb(dat6079_dot_cleaned_avg_scale)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_4a mode(dat6080_dot_cleaned_avg_scale)=2, lsize(dat6080_dot_cleaned_avg_scale)=1, rgb(dat6080_dot_cleaned_avg_scale)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4a mode(dat6081_dot_cleaned_avg_scale)=2, lsize(dat6081_dot_cleaned_avg_scale)=1, rgb(dat6081_dot_cleaned_avg_scale)=(0,0,0)
	
	// modify gfits
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6079_dot_cleaned_avg_scale)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale)=2, rgb(gfit_dat6079_dot_cleaned_avg_scale)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6080_dot_cleaned_avg_scale)=0, lsize(gfit_dat6080_dot_cleaned_avg_scale)=2, rgb(gfit_dat6080_dot_cleaned_avg_scale)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6081_dot_cleaned_avg_scale)=0, lsize(gfit_dat6081_dot_cleaned_avg_scale)=2, rgb(gfit_dat6081_dot_cleaned_avg_scale)=(0,0,0)
	
	Label /W=paper_figure_4a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Legend /W=paper_figure_4a /C/N=text0/J/F=0/A=LT "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale) Γ/T = 24.29\r\\s(gfit_dat6080_dot_cleaned_avg_scale) Γ/T = 9.48\r\\s(gfit_dat6081_dot_cleaned_avg_scale) Γ/T = 0.99"
	
//	Label /W=paper_figure_4a bottom "Sweepgate (centered by mid) (mV)"
	
//	ModifyGraph /W=paper_figure_4a muloffset={0.005,0}
//	SetAxis /W=paper_figure_4a bottom -8,8
	beautify_figure("paper_figure_4a")

endmacro




macro paper_v2_figure_4b()
// entropy 1281 1282 1283 1284

	Display; KillWindow /Z paper_figure_4b; DoWindow/C/O paper_figure_4b 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_scaled
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled
	
	
	// offset to 0
	dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	fit_dat1281_numerical_entropy_avg_interp_scaled -= fit_dat1281_numerical_entropy_avg_interp[0]
	fit_dat1282_numerical_entropy_avg_interp_scaled -= fit_dat1282_numerical_entropy_avg_interp[0]
	fit_dat1283_numerical_entropy_avg_interp_scaled -= fit_dat1283_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	// scale everything by the maximum fit value
	dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	fit_dat1281_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	fit_dat1282_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	fit_dat1283_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	fit_dat1284_numerical_entropy_avg_interp_scaled /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	// offset everything
	variable offset = 1
	dat1281_numerical_entropy_avg_interp_scaled += offset * 0
	dat1282_numerical_entropy_avg_interp_scaled += offset * 1
	dat1283_numerical_entropy_avg_interp_scaled += offset * 2
	dat1284_numerical_entropy_avg_interp_scaled += offset * 3
	
	fit_dat1281_numerical_entropy_avg_interp_scaled += offset * 0
	fit_dat1282_numerical_entropy_avg_interp_scaled += offset * 1
	fit_dat1283_numerical_entropy_avg_interp_scaled += offset * 2
	fit_dat1284_numerical_entropy_avg_interp_scaled += offset * 3
	
	
//	resampleWave(dat1281_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1282_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1283_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
//	resampleWave(dat1284_numerical_entropy_avg_interp_scaled, 500, measure_freq=12195/4)
	
	smooth 1000, dat1281_numerical_entropy_avg_interp_scaled
	smooth 1000, dat1282_numerical_entropy_avg_interp_scaled
	smooth 1000, dat1283_numerical_entropy_avg_interp_scaled
	smooth 2000, dat1284_numerical_entropy_avg_interp_scaled
	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4b dat1281_numerical_entropy_avg_interp_scaled vs dat1281_cs_cleaned_avg_occ_interp;  
	AppendToGraph /W=paper_figure_4b dat1282_numerical_entropy_avg_interp_scaled vs dat1282_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b dat1283_numerical_entropy_avg_interp_scaled vs dat1283_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b dat1284_numerical_entropy_avg_interp_scaled vs dat1284_cs_cleaned_avg_occ_interp;  
	
	///// append fits
	AppendToGraph /W=paper_figure_4b fit_dat1281_numerical_entropy_avg_interp_scaled vs fit_dat1281_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4b fit_dat1282_numerical_entropy_avg_interp_scaled vs fit_dat1282_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b fit_dat1283_numerical_entropy_avg_interp_scaled vs fit_dat1283_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b fit_dat1284_numerical_entropy_avg_interp_scaled vs fit_dat1284_cs_cleaned_avg_occ_interp;
	
	Label /W=paper_figure_4b bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	// modify data
	ModifyGraph /W=paper_figure_4b mode(dat1281_numerical_entropy_avg_interp_scaled)=2, lsize(dat1281_numerical_entropy_avg_interp_scaled)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_4b mode(dat1282_numerical_entropy_avg_interp_scaled)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4b mode(dat1283_numerical_entropy_avg_interp_scaled)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_4b mode(dat1284_numerical_entropy_avg_interp_scaled)=2, lsize(dat1284_numerical_entropy_avg_interp_scaled)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
	
	// modify fits
	ModifyGraph /W=paper_figure_4b mode(fit_dat1281_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1281_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1281_numerical_entropy_avg_interp_scaled)=(0,0,0)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1282_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1282_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1282_numerical_entropy_avg_interp_scaled)=(24158,34695,23901)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1283_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1283_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1283_numerical_entropy_avg_interp_scaled)=(52685,33924,12336)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1284_numerical_entropy_avg_interp_scaled)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled)=2, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled)=(47802,0,2056)
		
	
	Label /W=paper_figure_4b left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_4b")
	
	Legend/W=paper_figure_4b /C/N=text0/J/F=0/A=LT "\\s(fit_dat1281_numerical_entropy_avg_interp_scaled) Γ/T = 0.9\r\\s(fit_dat1282_numerical_entropy_avg_interp_scaled) Γ/T = 8.8\r\\s(fit_dat1283_numerical_entropy_avg_interp_scaled) Γ/T = 21.7\r\\s(fit_dat1284_numerical_entropy_avg_interp_scaled) Γ/T = 30.9"

//	ModifyGraph /W=paper_figure_4b  mirror=0,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
//	ModifyGraph /W=paper_figure_4b mirror(left)=1,mirror(bottom)=1
//	SetAxis /W=paper_figure_4b bottom -6,9
	
endmacro


function figure_2_conductance()
	///// SPRING CONDUCTANCE AND TRANSITION DATA ///// 
	string datnums = "6079;6088;6085;6082"; string gamma_type = "high"// high gamma
//	string datnums = "6080;6089;6086;6083"; string gamma_type = "mid" // mid gamma
//	string datnums = "6081;6090;6087;6084"; string gamma_type = "low" // low gamma
	
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
	
	TileWindows/O=1/C/P
end



function figure_3_conductance()
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




function figure_2_entropy()
	///// SPRING CONDUCTANCE AND TRANSITION DATA ///// 
//	string global_datnums = "6079;6088;6085;6082"; string gamma_type = "high"// high gamma
//	string global_datnums = "6080;6089;6086;6083"; string gamma_type = "mid" // mid gamma
//	string global_datnums = "6081;6090;6087;6084"; string gamma_type = "low" // low gamma
	
//	string global_datnums = "6100;6097;6094;6091"; string gamma_type = "high" // high gamma :: high field
	
//	string global_datnums = "6225;6234;6231;6228"; string gamma_type = "high" // high gamma :: 2-3 transition
//	string datnums = "6226;6235;6232;6229"; string gamma_type = "high" // high gamma :: 2-3 transition
	
	///// AUTUMN EXPERIMENT /////
	string gamma_type
	string entropy_datnums = "1281"; string global_datnums = "1285;1297;1293;1289"; gamma_type = "low"; info_mask_waves("1281", base_wave_name="_cs_cleaned_avg")
//	string entropy_datnums = "1282"; string global_datnums = "1286;1298;1294;1290"; gamma_type = "low"
//	string entropy_datnums = "1283"; string global_datnums = "1287;1299;1295;1291"; gamma_type = "high"; info_mask_waves("1283", base_wave_name="_cs_cleaned_avg")
//	string entropy_datnums = "1284"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1284", base_wave_name="_cs_cleaned_avg") // 100uV bias
//	string entropy_datnums = "1372"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 50uV bias
//	string entropy_datnums = "1373"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 250uV bias
//	string entropy_datnums = "1374"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 500uV bias
//	string entropy_datnums = "1439"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 1000uV bias
//	string entropy_datnums = "1473"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high" // 50uV bias :: symmetric

//	string e_temps = "23;100;300;500"
	string e_temps = "22.5;90;275;400"
	
	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
	string colour, e_temp
	variable red, green, blue
	
	int global_fit_conductance = 0
	int fit_conductance = 0
	int fit_entropy = 1
	
	variable num_dats = ItemsInList(global_datnums, ";")
	variable num_entropy_dats = ItemsInList(entropy_datnums, ";")
	
	///// ZAP NANs /////
	string ct_datnum, ct_wavename
	int i 
	for (i=0; i<num_dats; i++)
		ct_datnum = stringfromlist(i, global_datnums)
		ct_wavename = "dat" + ct_datnum + "_cs_cleaned_avg"
		zap_NaNs($ct_wavename, overwrite=1)
	endfor
	
	///// RUN GLOBAL FIT /////
	variable cond_chisq, occ_chisq, condocc_chisq
	[cond_chisq, occ_chisq, condocc_chisq] = run_global_fit(e_temps, global_datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums)	
	
	Display; KillWindow /Z figure_2a; DoWindow/C/O figure_2a
	Display; KillWindow /Z figure_2b; DoWindow/C/O figure_2b
	Display; KillWindow /Z figure_2c; DoWindow/C/O figure_2c
	
	string cond_avg, cond_avg_fit
	string trans_avg, trans_avg_fit
	string occ_avg, occ_avg_fit
	string dndt_avg, dndt_avg_fit
	string dndt_nrg_avg_fit
	string dndt_occ_avg, dndt_occ_avg_fit, dndt_occ_avg_coef
	string entropy_avg, entropy_avg_fit
	
	string occupation_coef_name
	
	string legend_text = ""
	variable datnum, entropy_datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, global_datnums))
		e_temp = stringfromlist(i, e_temps)
		
		if (i < num_entropy_dats)
			entropy_datnum = str2num(stringfromlist(i, entropy_datnums))
		endif
		
		// setting conduction names 
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		if (global_fit_conductance == 1)
			cond_avg_fit = "GFit_" + cond_avg
		else
			cond_avg_fit = "fit_" + cond_avg
		endif
		
		// setting charge transition names
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		if (global_fit_conductance == 1)
			trans_avg_fit = "fit_" + trans_avg
		else
			trans_avg_fit = "GFit_" + trans_avg
		endif
		
		// setting occupation names
		occ_avg = trans_avg + "_occ"
		occ_avg_fit = trans_avg_fit + "_occ"
		
		
		
		// setting dndt names
		dndt_avg = "dat" + num2str(entropy_datnum) + "_numerical_entropy_avg"
		dndt_avg_fit = "fit_" + dndt_avg
		dndt_nrg_avg_fit = "fit_nrg_" + dndt_avg
		
		// setting dndt occupation names
		dndt_occ_avg = "dat" + num2str(entropy_datnum) + "_cs_cleaned_avg_occ"
		dndt_occ_avg_fit = "fit_" + dndt_occ_avg
		
		dndt_occ_avg_coef = "coef_dat" + num2str(entropy_datnum) + "_cs_cleaned_avg"
		
		// setting entropy names
		entropy_avg = "dat" + num2str(entropy_datnum) + "_numerical_entropy_int_avg"
		entropy_avg_fit = "fit_" + entropy_avg

		
		legend_text = legend_text + "\\s(" + trans_avg_fit +  ") " +  e_temp + "mK\r"
		
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		//////////////////////////////////////////
		///// ADDING CONDUCTION VS SWEEPGATE /////
		//////////////////////////////////////////
//		AppendToGraph /W=figure_2a /L=l3/B=b3 $cond_avg; AppendToGraph /W=figure_2a /L=l3/B=b3 $cond_avg_fit;
//		ModifyGraph /W=figure_2a mode($cond_avg)=2, lsize($cond_avg)=1, rgb($cond_avg)=(red,green,blue)
//		ModifyGraph /W=figure_2a mode($cond_avg_fit)=0, lsize($cond_avg_fit)=2, rgb($cond_avg_fit)=(red,green,blue)
		
		
		//////////////////////////////////////////
		///// ADDING OCCUPATION VS SWEEPGATE /////
		//////////////////////////////////////////
		///// Appending traces to panel ca /////
		AppendToGraph /W=figure_2a /L=left/B=bottom $trans_avg; AppendToGraph /W=figure_2a /L=left/B=bottom $trans_avg_fit;
		ModifyGraph /W=figure_2a mode($trans_avg)=2, lsize($trans_avg)=1, rgb($trans_avg)=(red,green,blue)
		ModifyGraph /W=figure_2a mode($trans_avg_fit)=0, lsize($trans_avg_fit)=2, rgb($trans_avg_fit)=(red,green,blue)
		
		///// Appending traces to panel cb /////
		AppendToGraph /W=figure_2a /L=l1/B=b1 $occ_avg; AppendToGraph /W=figure_2a /L=l1/B=b1 $occ_avg_fit;
		ModifyGraph /W=figure_2a mode($occ_avg)=2, lsize($occ_avg)=1, rgb($occ_avg)=(red,green,blue)
		ModifyGraph /W=figure_2a mode($occ_avg_fit)=0, lsize($occ_avg_fit)=2, rgb($occ_avg_fit)=(red,green,blue)		
		
		if (i < num_entropy_dats)
			/////////////////////////////////////
	//		///// ADDING DNDT VS SWEEPGATE //////
	//		/////////////////////////////////////
			wave dndt_avg_wav = $dndt_avg
			wave dndt_avg_fit_wav = $dndt_avg_fit
			wave dndt_nrg_avg_fit_wav = $dndt_nrg_avg_fit
			
			variable dndt_offset = dndt_avg_fit_wav[0]
			dndt_avg_wav -= dndt_offset
			dndt_avg_fit_wav -= dndt_offset
			dndt_nrg_avg_fit_wav -= dndt_offset
			
			AppendToGraph /W=figure_2b /L=left/B=bottom $dndt_avg
			ModifyGraph /W=figure_2b mode($dndt_avg)=2, lsize($dndt_avg)=1, rgb($dndt_avg)=(red,green,blue)
			
			AppendToGraph /W=figure_2b /L=left/B=bottom $dndt_avg_fit
			ModifyGraph /W=figure_2b mode($dndt_avg_fit)=0, lsize($dndt_avg_fit)=2, rgb($dndt_avg_fit)=(red,green,blue)
			
			
			AppendToGraph /W=figure_2b /L=left/B=bottom $dndt_nrg_avg_fit
			ModifyGraph /W=figure_2b mode($dndt_nrg_avg_fit)=0, lsize($dndt_nrg_avg_fit)=2, rgb($dndt_nrg_avg_fit)=(0,0,0)

			duplicate /o $dndt_avg_fit $(dndt_avg_fit + "_int")
			
			wave dndt_int_avg_fit_wav = $(dndt_avg_fit + "_int")
			
			Integrate $dndt_avg_fit /D = dndt_int_avg_fit_wav
			
			variable int_entropy_scale
			
			wave occ_coef = $dndt_occ_avg_coef
			
			int_entropy_scale = abs((1/(2*occ_coef[7]*8.617e-5*0.0067))*0.0225*8.617e-5*2*(occ_coef[1]))*50
			
//			if (entropy_datnum == 1281)
//				int_entropy_scale = (1/(0.24299*8.617e-5*0.0067))*0.0225*8.617e-5*(0.212027)
//			elseif (entropy_datnum == 1282)
//				int_entropy_scale = (1/(0.22623*8.617e-5*0.0067))*0.0225*8.617e-5*(0.0177491)
//			elseif (entropy_datnum == 1283)
//				int_entropy_scale = (1/(0.10034538*8.617e-5*0.0067))*0.0225*8.617e-5*(0.0051304582)
//			elseif (entropy_datnum == 1284)
//				int_entropy_scale = (1/(0.095089674*8.617e-5*0.0067))*0.0225*8.617e-5*(0.0028941352)
//			endif
//			int_entropy_scale = 1
			print "Scaling factor = " + num2str(int_entropy_scale)
			print "Max int val = " + num2str(dndt_int_avg_fit_wav[inf])
			AppendToGraph /W=figure_2b /r /B=bottom dndt_int_avg_fit_wav
			
			
			dndt_int_avg_fit_wav *= int_entropy_scale
//			ModifyGraph /W=figure_2b muloffset(dndt_int_avg_fit_wav)={0, int_entropy_scale}
			
			/////////////////////////////////////
	//		///// ADDING DNDT VS OCCUPATION /////
	//		/////////////////////////////////////
			variable numpts_occupation = 10000
			create_x_wave($dndt_occ_avg)
			wave x_wave
			
			////////////////////////////////////
			///// interpolating data waves /////
			////////////////////////////////////
	//		variable minx, maxx
	//		[minx, maxx] = find_overlap_mask($(trans_avg+"_mask"), $(trans_avg+"_mask"))
			
			// interpolating occupation to have higher density of points
			string dndt_vs_occ_data_wave_name_x = dndt_occ_avg + "_interp"
			interpolate_wave(dndt_vs_occ_data_wave_name_x, $dndt_occ_avg, numpts_to_interp=10000)
			
			// interpolating conduction to have data at same x points as occuptaion data
			string dndt_vs_occ_data_wave_name_y = dndt_avg + "_interp"
			interpolate_wave(dndt_vs_occ_data_wave_name_y, $dndt_avg, wave_to_duplicate=$dndt_vs_occ_data_wave_name_x)
			
			// deleting points outside of mask
	//		delete_points_from_x($dndt_vs_occ_data_wave_name_x, minx, maxx)
	//		delete_points_from_x($dndt_vs_occ_data_wave_name_y, minx, maxx)
			
			
			///////////////////////////////////
			///// interpolating fit waves /////
			///////////////////////////////////
			string dndt_vs_occ_fit_wave_name_x = dndt_occ_avg_fit + "_interp"
			interpolate_wave(dndt_vs_occ_fit_wave_name_x, $dndt_occ_avg_fit, numpts_to_interp=10000)
			
			string dndt_vs_occ_fit_wave_name_y = dndt_avg_fit + "_interp"
			interpolate_wave(dndt_vs_occ_fit_wave_name_y, $dndt_avg_fit, wave_to_duplicate=$dndt_vs_occ_fit_wave_name_x)
	
	//		delete_points_from_x($dndt_vs_occ_fit_wave_name_x, minx, maxx)
	//		delete_points_from_x($dndt_vs_occ_fit_wave_name_y, minx, maxx)
	
	
			///// interpolating nrg fit wave /////
//			string dndt_nrg_vs_occ_fit_wave_name_x = dndt_nrg_avg_fit + "_interp"
//			interpolate_wave(dndt_vs_occ_fit_wave_name_x, $dndt_nrg_avg_fit, numpts_to_interp=10000)
//			
			string dndt_nrg_vs_occ_fit_wave_name_y = dndt_nrg_avg_fit + "_interp"
			interpolate_wave(dndt_nrg_vs_occ_fit_wave_name_y, $dndt_nrg_avg_fit, wave_to_duplicate=$dndt_vs_occ_fit_wave_name_x)
			
	
			AppendToGraph /W=figure_2c /L=left/B=bottom $dndt_vs_occ_data_wave_name_y vs $dndt_vs_occ_data_wave_name_x
			AppendToGraph /W=figure_2c /L=left/B=bottom $dndt_vs_occ_fit_wave_name_y vs $dndt_vs_occ_fit_wave_name_x;
			AppendToGraph /W=figure_2c /L=left/B=bottom $dndt_nrg_vs_occ_fit_wave_name_y vs $dndt_vs_occ_fit_wave_name_x;
			
			ModifyGraph /W=figure_2c mode($dndt_vs_occ_data_wave_name_y)=2, lsize($dndt_vs_occ_data_wave_name_y)=1, rgb($dndt_vs_occ_data_wave_name_y)=(red,green,blue)
			ModifyGraph /W=figure_2c mode($dndt_vs_occ_fit_wave_name_y)=0, lsize($dndt_vs_occ_fit_wave_name_y)=2, rgb($dndt_vs_occ_fit_wave_name_y)=(red,green,blue)
			ModifyGraph /W=figure_2c mode($dndt_nrg_vs_occ_fit_wave_name_y)=0, lsize($dndt_nrg_vs_occ_fit_wave_name_y)=2, rgb($dndt_nrg_vs_occ_fit_wave_name_y)=(0,0,0)
		endif
	endfor
	
	///// axis labelling goes from top plot to bottom plot
	///// [b3, l3] [b2, l2] [bottom left]
	
	
	///// setting y-scale of axis /////
//	SetAxis /W=figure_2a left 0,*
//	SetAxis /W=figure_2a bottom 0,1
	
	ModifyGraph /W=figure_2a axisEnab(l1)={0.75,0.85}
	ModifyGraph /W=figure_2a axisEnab(b1)={0.6,0.9},freePos(b1)={0,l1}
	ModifyGraph /W=figure_2a freePos(l1)={-1000,b1}
	ModifyGraph /W=figure_2a lblPos(l1)=50,lblPos(b1)=40
	
	
	///// setting  axis labels /////
	Label /W=figure_2a left "Current (nA)"
	Label /W=figure_2a l1 "Occupation (.arb)"
	Label /W=figure_2a bottom "Sweep Gate (mV)"
	Label /W=figure_2a b1 "Sweep Gate (mV)"
	
	Label /W=figure_2b left "dN/dT"
	Label /W=figure_2b bottom "Sweep Gate (mV)"
	
	Label /W=figure_2c left "dN/dT"
	Label /W=figure_2c bottom "Occupation (.arb)"
	
	
	///// off-setting labels from the axis /////
//	ModifyGraph /W=figure_2a lblPos(l2)=150
//	ModifyGraph /W=figure_2a lblPos(l3)=150
//	ModifyGraph /W=figure_2a lblPos(l1)=150
//	ModifyGraph /W=figure_2a lblPos(b1)=80
//	ModifyGraph /W=figure_2a lblPos(b3)=80
	
	
	///// adding legend /////
	Legend/W=figure_2a/C/N=legend_figc/J/A=LT legend_text
	Legend/W=figure_2c
	Legend/W=figure_2b
	
	beautify_figure("figure_2a")
	beautify_figure("figure_2b")
	beautify_figure("figure_2c")
	
	TileWindows/O=1/C/P
end




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

	Legend/C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 20"
	
//	Label /W=figure_nrg_occ_aligned bottom "Energy (arb.)"
//	Label /W=figure_nrg_occ_aligned left "Occupation"
	SetAxis /W=figure_nrg_occ_aligned bottom -1.2e+03,1.2e+03
	ModifyGraph /W=figure_nrg_occ_aligned mirror=1, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=14, tick=2, gFont="Calibri", gfSize=14, gfSize=14
	
//	Legend/C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 20"

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

//	Legend/C/N=text0/J/F=0 "\\s(occ_nrg_pick) Γ/T = 0.1\r\\s(occ_nrg_pick#1) Γ/T = 1\r\\s(occ_nrg_pick#2) Γ/T = 5\r\\s(occ_nrg_pick#3) Γ/T = 7"


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
	
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_similar_fit)  Γ/T = 1.3\r\\s(int_entropy_med_fit)  Γ/T = 5\r\\s(int_entropy_strong_fit) Γ/T = 18"
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_strong_fit) Γ/T = 18"
	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit) Γ/T = weak\r\\s(int_entropy_strong_fit) Γ/T = strong"


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
	
//	Legend /W=figure_poster_gamma_entropy /C/N=text0/J/F=0/A=LT/X=5.38/Y=0.00 "\\s(int_entropy_weak_fit)  Γ/T < 0.01\r\\s(int_entropy_similar_fit)  Γ/T = 1.3\r\\s(int_entropy_med_fit)  Γ/T = 5\r\\s(int_entropy_strong_fit) Γ/T = 18"
////	Label /W=figure_poster_gamma_entropy bottom "Sweep Gate (mV)\\u#2"
////	Label /W=figure_poster_gamma_entropy left "Entropy (kB)\\u#2"
//	SetAxis /W=figure_poster_gamma_entropy bottom -3,3
//	Label /W=figure_poster_gamma_entropy bottom "\\u#2"
//	Label /W=figure_poster_gamma_entropy left "\\u#2"
//	ModifyGraph /W=figure_poster_gamma_entropy mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14

end