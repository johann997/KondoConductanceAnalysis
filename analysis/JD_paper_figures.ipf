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
	int font_size = 15
//	ModifyGraph /W=$figure_name mirror=1,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
	ModifyGraph /W=$figure_name mirror=1, nticks=5, axThick=0.5, btLen=3, stLen=2, fsize=font_size, tick=2, gFont="Calibri", gfSize=font_size, lowTrip(bottom)=0.0001, lowTrip(left)=0.01//, width=1*200, height=1*200/1.6180339887
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
	
	SavePICT/P=figure_folder/E=-5/RES=1000/o/Q=1 as png_name
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
	duplicate /o dat6079_cs_cleaned_avg dat6079_cs_cleaned_avg_scale_fig2a
	duplicate /o dat6088_cs_cleaned_avg dat6088_cs_cleaned_avg_scale_fig2a
	duplicate /o dat6085_cs_cleaned_avg dat6085_cs_cleaned_avg_scale_fig2a
	duplicate /o dat6082_cs_cleaned_avg dat6082_cs_cleaned_avg_scale_fig2a
	
	duplicate /o fit_dat6079_cs_cleaned_avg fit_dat6079_cs_cleaned_avg_scale_fig2a
	duplicate /o fit_dat6088_cs_cleaned_avg fit_dat6088_cs_cleaned_avg_scale_fig2a
	duplicate /o fit_dat6085_cs_cleaned_avg fit_dat6085_cs_cleaned_avg_scale_fig2a
	duplicate /o fit_dat6082_cs_cleaned_avg fit_dat6082_cs_cleaned_avg_scale_fig2a
	
	
	////////// removing linear and quadratic terms /////
	// data
	create_x_wave(dat6079_cs_cleaned_avg_scale_fig2a)
	dat6079_cs_cleaned_avg_scale_fig2a -= (coef_dat6079_cs_cleaned_avg[5]*x_wave[p] + coef_dat6079_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6079_cs_cleaned_avg[2], x_wave[inf]-coef_dat6079_cs_cleaned_avg[2], dat6079_cs_cleaned_avg_scale_fig2a

	create_x_wave(dat6088_cs_cleaned_avg_scale_fig2a)
	dat6088_cs_cleaned_avg_scale_fig2a -= (coef_dat6088_cs_cleaned_avg[5]*x_wave[p] + coef_dat6088_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6088_cs_cleaned_avg[2], x_wave[inf]-coef_dat6088_cs_cleaned_avg[2], dat6088_cs_cleaned_avg_scale_fig2a
	
	create_x_wave(dat6085_cs_cleaned_avg_scale_fig2a)
	dat6085_cs_cleaned_avg_scale_fig2a -= (coef_dat6085_cs_cleaned_avg[5]*x_wave[p] + coef_dat6085_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6085_cs_cleaned_avg[2], x_wave[inf]-coef_dat6085_cs_cleaned_avg[2], dat6085_cs_cleaned_avg_scale_fig2a
	
	create_x_wave(dat6082_cs_cleaned_avg_scale_fig2a)
	dat6082_cs_cleaned_avg_scale_fig2a -= (coef_dat6082_cs_cleaned_avg[5]*x_wave[p] + coef_dat6082_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6082_cs_cleaned_avg[2], x_wave[inf]-coef_dat6082_cs_cleaned_avg[2], dat6082_cs_cleaned_avg_scale_fig2a
	
	// fit
	create_x_wave(fit_dat6079_cs_cleaned_avg_scale_fig2a)
	fit_dat6079_cs_cleaned_avg_scale_fig2a -= (coef_dat6079_cs_cleaned_avg[5]*x_wave[p] + coef_dat6079_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6079_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6079_cs_cleaned_avg[2], x_wave[inf]-coef_dat6079_cs_cleaned_avg[2], fit_dat6079_cs_cleaned_avg_scale_fig2a
	
	create_x_wave(fit_dat6088_cs_cleaned_avg_scale_fig2a)
	fit_dat6088_cs_cleaned_avg_scale_fig2a -= (coef_dat6088_cs_cleaned_avg[5]*x_wave[p] + coef_dat6088_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6088_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6088_cs_cleaned_avg[2], x_wave[inf]-coef_dat6088_cs_cleaned_avg[2], fit_dat6088_cs_cleaned_avg_scale_fig2a
	
	create_x_wave(fit_dat6085_cs_cleaned_avg_scale_fig2a)
	fit_dat6085_cs_cleaned_avg_scale_fig2a -= (coef_dat6085_cs_cleaned_avg[5]*x_wave[p] + coef_dat6085_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6085_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6085_cs_cleaned_avg[2], x_wave[inf]-coef_dat6085_cs_cleaned_avg[2], fit_dat6085_cs_cleaned_avg_scale_fig2a
	
	create_x_wave(fit_dat6082_cs_cleaned_avg_scale_fig2a)
	fit_dat6082_cs_cleaned_avg_scale_fig2a -= (coef_dat6082_cs_cleaned_avg[5]*x_wave[p] + coef_dat6082_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat6082_cs_cleaned_avg[4]
//	setscale /I x x_wave[0]-coef_dat6082_cs_cleaned_avg[2], x_wave[inf]-coef_dat6082_cs_cleaned_avg[2], fit_dat6082_cs_cleaned_avg_scale_fig2a
	
	
//	// offset everything
//	variable offset = 0.003
//	dat6079_cs_cleaned_avg_scale_fig2a += offset * 0
//	dat6088_cs_cleaned_avg_scale_fig2a += offset * 1
//	dat6085_cs_cleaned_avg_scale_fig2a += offset * 2
//	dat6082_cs_cleaned_avg_scale_fig2a += offset * 3
//	
//	fit_dat6079_cs_cleaned_avg_scale_fig2a += offset * 0
//	fit_dat6088_cs_cleaned_avg_scale_fig2a += offset * 1
//	fit_dat6085_cs_cleaned_avg_scale_fig2a += offset * 2
//	fit_dat6082_cs_cleaned_avg_scale_fig2a += offset * 3
	
	
	/////// charge transition //////
	///// append data
	AppendToGraph /W=paper_figure_2a dat6079_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_2a dat6088_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_2a dat6085_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_2a dat6082_cs_cleaned_avg_scale_fig2a; 
	
	///// append fits
	AppendToGraph /W=paper_figure_2a fit_dat6079_cs_cleaned_avg_scale_fig2a;
	AppendToGraph /W=paper_figure_2a fit_dat6088_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_2a fit_dat6085_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_2a fit_dat6082_cs_cleaned_avg_scale_fig2a;
	
	// offset 
	variable offset = 0.0015
	variable const_offset = coef_dat6082_cs_cleaned_avg[4]
	ModifyGraph /W=paper_figure_2a offset(dat6079_cs_cleaned_avg_scale_fig2a)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6088_cs_cleaned_avg_scale_fig2a)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6085_cs_cleaned_avg_scale_fig2a)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(dat6082_cs_cleaned_avg_scale_fig2a)={0,offset * 3 + const_offset}
	
	ModifyGraph /W=paper_figure_2a offset(fit_dat6079_cs_cleaned_avg_scale_fig2a)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6088_cs_cleaned_avg_scale_fig2a)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6085_cs_cleaned_avg_scale_fig2a)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_2a offset(fit_dat6082_cs_cleaned_avg_scale_fig2a)={0,offset * 3 + const_offset}
	
	
	string marker_size
	// modify data
	marker_size = "dat6079_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat6079_cs_cleaned_avg_scale_fig2a, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2a mode(dat6079_cs_cleaned_avg_scale_fig2a)=3, marker(dat6079_cs_cleaned_avg_scale_fig2a)=41, lsize(dat6079_cs_cleaned_avg_scale_fig2a)=1, rgb(dat6079_cs_cleaned_avg_scale_fig2a)=(0,0,65535), mrkThick(dat6079_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat6079_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	marker_size = "dat6088_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat6088_cs_cleaned_avg_scale_fig2a, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2a mode(dat6088_cs_cleaned_avg_scale_fig2a)=3, marker(dat6088_cs_cleaned_avg_scale_fig2a)=41, lsize(dat6088_cs_cleaned_avg_scale_fig2a)=1, rgb(dat6088_cs_cleaned_avg_scale_fig2a)=(29524,1,58982), mrkThick(dat6088_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat6088_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	marker_size = "dat6085_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat6085_cs_cleaned_avg_scale_fig2a, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2a mode(dat6085_cs_cleaned_avg_scale_fig2a)=3, marker(dat6085_cs_cleaned_avg_scale_fig2a)=41, lsize(dat6085_cs_cleaned_avg_scale_fig2a)=1, rgb(dat6085_cs_cleaned_avg_scale_fig2a)=(64981,37624,14500), mrkThick(dat6085_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat6085_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	marker_size = "dat6082_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat6082_cs_cleaned_avg_scale_fig2a, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2a mode(dat6082_cs_cleaned_avg_scale_fig2a)=3, marker(dat6082_cs_cleaned_avg_scale_fig2a)=41, lsize(dat6082_cs_cleaned_avg_scale_fig2a)=1, rgb(dat6082_cs_cleaned_avg_scale_fig2a)=(65535,0,0), mrkThick(dat6082_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat6082_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	// modify fits
	ModifyGraph /W=paper_figure_2a mode(fit_dat6079_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat6079_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat6079_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (0,0,65535)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6088_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat6088_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat6088_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (29524,1,58982)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6085_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat6085_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat6085_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (64981,37624,14500)
	ModifyGraph /W=paper_figure_2a mode(fit_dat6082_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat6082_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat6082_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (65535,0,0)
	
	Label /W=paper_figure_2a left "Current (nA)"
	SetAxis /W=paper_figure_2a bottom -10,10
	
//	Legend /W=paper_figure_2a /C/N=text0/J/F=0/F=0 "\\Zr080\\s(fit_dat6079_cs_cleaned_avg_scale_fig2a) 22.5 mK\r\\s(fit_dat6088_cs_cleaned_avg_scale_fig2a) 100 mK\r\\s(fit_dat6085_cs_cleaned_avg_scale_fig2a) 300 mK\r\\s(fit_dat6082_cs_cleaned_avg_scale_fig2a) 500 mK"
//	Legend /W=paper_figure_2a /C/N=text0/J/F=0/F=0 "\\Zr080\\s(dat6079_cs_cleaned_avg_scale_fig2a) 22.5 mK\r\\s(dat6088_cs_cleaned_avg_scale_fig2a) 100 mK\r\\s(dat6085_cs_cleaned_avg_scale_fig2a) 300 mK\r\\s(dat6082_cs_cleaned_avg_scale_fig2a) 500 mK"

	
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
//	ModifyGraph /W=paper_figure_2a muloffset={0.005,0}
	
	
	beautify_figure("paper_figure_2a")
	
	
	AppendToGraph /W=paper_figure_2a /l=l1 /b=b1, dat6079_cs_cleaned_avg
	
	ModifyGraph /W=paper_figure_2a muloffset={0.005,0}
	
	ModifyGraph /W=paper_figure_2a axisEnab(l1)={0.2,0.55},axisEnab(b1)={0.15,0.5},freePos(l1)={-40,b1},freePos(b1)={0,l1}
	SetAxis /W=paper_figure_2a b1 -40,40
	
	Legend /W=paper_figure_2a /C/N=text0/J/F=0/F=0 "\\Zr080\\s(dat6079_cs_cleaned_avg_scale_fig2a) 22.5 mK\r\\s(dat6088_cs_cleaned_avg_scale_fig2a) 100 mK\r\\s(dat6085_cs_cleaned_avg_scale_fig2a) 300 mK\r\\s(dat6082_cs_cleaned_avg_scale_fig2a) 500 mK"

	
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
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale_fig2b
	duplicate /o dat6088_dot_cleaned_avg_interp dat6088_dot_cleaned_avg_scale_fig2b
	duplicate /o dat6085_dot_cleaned_avg_interp dat6085_dot_cleaned_avg_scale_fig2b
	duplicate /o dat6082_dot_cleaned_avg_interp dat6082_dot_cleaned_avg_scale_fig2b
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig2b
	duplicate /o gfit_dat6088_dot_cleaned_avg_interp gfit_dat6088_dot_cleaned_avg_scale_fig2b
	duplicate /o gfit_dat6085_dot_cleaned_avg_interp gfit_dat6085_dot_cleaned_avg_scale_fig2b
	duplicate /o gfit_dat6082_dot_cleaned_avg_interp gfit_dat6082_dot_cleaned_avg_scale_fig2b
	
	
	////////// removing linear and quadratic terms /////

	/////// charge transition //////
	
//		///// translate data
//	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale_fig2b, dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6088_dot_cleaned_avg_scale_fig2b, dat6088_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6085_dot_cleaned_avg_scale_fig2b, dat6085_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6082_dot_cleaned_avg_scale_fig2b, dat6082_cs_cleaned_avg_occ_interp) 
//
//	///// translate fit
//	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale_fig2b, fit_dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6088_dot_cleaned_avg_scale_fig2b, fit_dat6088_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6085_dot_cleaned_avg_scale_fig2b, fit_dat6085_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6082_dot_cleaned_avg_scale_fig2b, fit_dat6082_cs_cleaned_avg_occ_interp)  
	
	
//	// scaling occupation fits
//	create_x_wave(gfit_dat6079_dot_cleaned_avg_scale_fig2b)
//	setscale /I x 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[0]+coef_dat6079_cs_cleaned_avg[2], 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6079_cs_cleaned_avg[2], gfit_dat6079_dot_cleaned_avg_scale_fig2b
//
//	create_x_wave(gfit_dat6088_dot_cleaned_avg_scale_fig2b)
//	setscale /I x 1/coef_dat6088_cs_cleaned_avg[1]*x_wave[0]+coef_dat6088_cs_cleaned_avg[2], 1/coef_dat6088_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6088_cs_cleaned_avg[2], gfit_dat6088_dot_cleaned_avg_scale_fig2b
//
//	create_x_wave(gfit_dat6085_dot_cleaned_avg_scale_fig2b)
//	setscale /I x 1/coef_dat6085_cs_cleaned_avg[1]*x_wave[0]+coef_dat6085_cs_cleaned_avg[2], 1/coef_dat6085_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6085_cs_cleaned_avg[2], gfit_dat6085_dot_cleaned_avg_scale_fig2b
//
//	create_x_wave(gfit_dat6082_dot_cleaned_avg_scale_fig2b)
//	setscale /I x 1/coef_dat6082_cs_cleaned_avg[1]*x_wave[0]+coef_dat6082_cs_cleaned_avg[2], 1/coef_dat6082_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6082_cs_cleaned_avg[2], gfit_dat6082_dot_cleaned_avg_scale_fig2b
	
	// scaling occupation fits
	create_x_wave(gfit_dat6079_dot_cleaned_avg_scale_fig2b)
	setscale /I x 1/coef_dat6079_dot_cleaned_avg[1]*x_wave[0]+coef_dat6079_dot_cleaned_avg[2], 1/coef_dat6079_dot_cleaned_avg[1]*x_wave[inf]+coef_dat6079_dot_cleaned_avg[2], gfit_dat6079_dot_cleaned_avg_scale_fig2b

	create_x_wave(gfit_dat6088_dot_cleaned_avg_scale_fig2b)
	setscale /I x 1/coef_dat6088_dot_cleaned_avg[1]*x_wave[0]+coef_dat6088_dot_cleaned_avg[2], 1/coef_dat6088_dot_cleaned_avg[1]*x_wave[inf]+coef_dat6088_dot_cleaned_avg[2], gfit_dat6088_dot_cleaned_avg_scale_fig2b

	create_x_wave(gfit_dat6085_dot_cleaned_avg_scale_fig2b)
	setscale /I x 1/coef_dat6085_dot_cleaned_avg[1]*x_wave[0]+coef_dat6085_dot_cleaned_avg[2], 1/coef_dat6085_dot_cleaned_avg[1]*x_wave[inf]+coef_dat6085_dot_cleaned_avg[2], gfit_dat6085_dot_cleaned_avg_scale_fig2b

	create_x_wave(gfit_dat6082_dot_cleaned_avg_scale_fig2b)
	setscale /I x 1/coef_dat6082_dot_cleaned_avg[1]*x_wave[0]+coef_dat6082_dot_cleaned_avg[2], 1/coef_dat6082_dot_cleaned_avg[1]*x_wave[inf]+coef_dat6082_dot_cleaned_avg[2], gfit_dat6082_dot_cleaned_avg_scale_fig2b
	
//	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////

	///// append gfits
	AppendToGraph /W=paper_figure_2b gfit_dat6079_dot_cleaned_avg_scale_fig2b;
	AppendToGraph /W=paper_figure_2b gfit_dat6088_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_2b gfit_dat6085_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_2b gfit_dat6082_dot_cleaned_avg_scale_fig2b;
	
	
	///// append data
	AppendToGraph /W=paper_figure_2b dat6079_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_2b dat6088_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_2b dat6085_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_2b dat6082_dot_cleaned_avg_scale_fig2b; 
	
	
	Label /W=paper_figure_2b bottom "Sweepgate  (mV)"
	
	
	string marker_size
	// modify data
	marker_size = "dat6079_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat6079_dot_cleaned_avg_scale_fig2b, 14, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2b mode(dat6079_dot_cleaned_avg_scale_fig2b)=3, marker(dat6079_dot_cleaned_avg_scale_fig2b)=41, lsize(dat6079_dot_cleaned_avg_scale_fig2b)=1, rgb(dat6079_dot_cleaned_avg_scale_fig2b)=(0,0,65535), mrkThick(dat6079_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat6079_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6088_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat6088_dot_cleaned_avg_scale_fig2b, 26, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2b mode(dat6088_dot_cleaned_avg_scale_fig2b)=3, marker(dat6088_dot_cleaned_avg_scale_fig2b)=41, lsize(dat6088_dot_cleaned_avg_scale_fig2b)=1, rgb(dat6088_dot_cleaned_avg_scale_fig2b)=(29524,1,58982), mrkThick(dat6088_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat6088_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6085_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat6085_dot_cleaned_avg_scale_fig2b, 26, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2b mode(dat6085_dot_cleaned_avg_scale_fig2b)=3, marker(dat6085_dot_cleaned_avg_scale_fig2b)=41, lsize(dat6085_dot_cleaned_avg_scale_fig2b)=1, rgb(dat6085_dot_cleaned_avg_scale_fig2b)=(64981,37624,14500), mrkThick(dat6085_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat6085_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6082_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat6082_dot_cleaned_avg_scale_fig2b, 26, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2b mode(dat6082_dot_cleaned_avg_scale_fig2b)=3, marker(dat6082_dot_cleaned_avg_scale_fig2b)=41, lsize(dat6082_dot_cleaned_avg_scale_fig2b)=1, rgb(dat6082_dot_cleaned_avg_scale_fig2b)=(65535,0,0), mrkThick(dat6082_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat6082_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3}
	
	// modify gfits
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6079_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat6079_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (0,0,65535)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6088_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat6088_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat6088_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (29524,1,58982)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6085_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat6085_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat6085_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (64981,37624,14500)
	ModifyGraph /W=paper_figure_2b mode(gfit_dat6082_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat6082_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat6082_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (65535,0,0)
	
	Label /W=paper_figure_2b left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"

//	Legend /W=paper_figure_2b /C/N=text0/J/F=0 "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig2b) 22.5 mK\r\\s(gfit_dat6088_dot_cleaned_avg_scale_fig2b) 100 mK\r\\s(gfit_dat6085_dot_cleaned_avg_scale_fig2b) 300 mK\r\\s(gfit_dat6082_dot_cleaned_avg_scale_fig2b) 500 mK"
	Legend /W=paper_figure_2b /C/N=text0/J/F=0 "\\Zr080\\s(dat6079_dot_cleaned_avg_scale_fig2b) 22.5 mK\r\\s(dat6088_dot_cleaned_avg_scale_fig2b) 100 mK\r\\s(dat6085_dot_cleaned_avg_scale_fig2b) 300 mK\r\\s(dat6082_dot_cleaned_avg_scale_fig2b) 500 mK"

	SetAxis /W=paper_figure_2b bottom -10,10
	ModifyGraph /W=paper_figure_2b muloffset={0.005,0}
	
	beautify_figure("paper_figure_2b")

endmacro



macro paper_v2_figure_2c_strong()
// data from summer cool down
//Temp	 22.5 100  300  500
//Datnum 6079 6088 6085 6082


// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_2c; DoWindow/C/O paper_figure_2c 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale_fig2c
	duplicate /o dat6088_dot_cleaned_avg_interp dat6088_dot_cleaned_avg_scale_fig2c
	duplicate /o dat6085_dot_cleaned_avg_interp dat6085_dot_cleaned_avg_scale_fig2c
	duplicate /o dat6082_dot_cleaned_avg_interp dat6082_dot_cleaned_avg_scale_fig2c
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig2c
	duplicate /o gfit_dat6088_dot_cleaned_avg_interp gfit_dat6088_dot_cleaned_avg_scale_fig2c
	duplicate /o gfit_dat6085_dot_cleaned_avg_interp gfit_dat6085_dot_cleaned_avg_scale_fig2c
	duplicate /o gfit_dat6082_dot_cleaned_avg_interp gfit_dat6082_dot_cleaned_avg_scale_fig2c



	///// append gfits
	AppendToGraph /W=paper_figure_2c gfit_dat6079_dot_cleaned_avg_scale_fig2c vs fit_dat6079_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_2c gfit_dat6088_dot_cleaned_avg_scale_fig2c vs fit_dat6088_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_2c gfit_dat6085_dot_cleaned_avg_scale_fig2c vs fit_dat6085_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_2c gfit_dat6082_dot_cleaned_avg_scale_fig2c vs fit_dat6082_cs_cleaned_avg_occ_interp;
	
	
	///// append data
	AppendToGraph /W=paper_figure_2c dat6079_dot_cleaned_avg_scale_fig2c vs dat6079_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_2c dat6088_dot_cleaned_avg_scale_fig2c vs dat6088_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_2c dat6085_dot_cleaned_avg_scale_fig2c vs dat6085_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_2c dat6082_dot_cleaned_avg_scale_fig2c vs dat6082_cs_cleaned_avg_occ_interp; 
	
	
	Label /W=paper_figure_2c bottom "Occupation (.arb)"
	
	
	string marker_size
	// modify data
	marker_size = "dat6079_dot_cleaned_avg_scale_fig2c" + "_marker_size"; create_marker_size(dat6079_dot_cleaned_avg_scale_fig2c, 14, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2c mode(dat6079_dot_cleaned_avg_scale_fig2c)=3, marker(dat6079_dot_cleaned_avg_scale_fig2c)=41, lsize(dat6079_dot_cleaned_avg_scale_fig2c)=1, rgb(dat6079_dot_cleaned_avg_scale_fig2c)=(0,0,65535), mrkThick(dat6079_dot_cleaned_avg_scale_fig2c)=0.5, zmrkSize(dat6079_dot_cleaned_avg_scale_fig2c)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6088_dot_cleaned_avg_scale_fig2c" + "_marker_size"; create_marker_size(dat6088_dot_cleaned_avg_scale_fig2c, 20, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2c mode(dat6088_dot_cleaned_avg_scale_fig2c)=3, marker(dat6088_dot_cleaned_avg_scale_fig2c)=41, lsize(dat6088_dot_cleaned_avg_scale_fig2c)=1, rgb(dat6088_dot_cleaned_avg_scale_fig2c)=(29524,1,58982), mrkThick(dat6088_dot_cleaned_avg_scale_fig2c)=0.5, zmrkSize(dat6088_dot_cleaned_avg_scale_fig2c)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6085_dot_cleaned_avg_scale_fig2c" + "_marker_size"; create_marker_size(dat6085_dot_cleaned_avg_scale_fig2c, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2c mode(dat6085_dot_cleaned_avg_scale_fig2c)=3, marker(dat6085_dot_cleaned_avg_scale_fig2c)=41, lsize(dat6085_dot_cleaned_avg_scale_fig2c)=1, rgb(dat6085_dot_cleaned_avg_scale_fig2c)=(64981,37624,14500), mrkThick(dat6085_dot_cleaned_avg_scale_fig2c)=0.5, zmrkSize(dat6085_dot_cleaned_avg_scale_fig2c)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat6082_dot_cleaned_avg_scale_fig2c" + "_marker_size"; create_marker_size(dat6082_dot_cleaned_avg_scale_fig2c, 30, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_2c mode(dat6082_dot_cleaned_avg_scale_fig2c)=3, marker(dat6082_dot_cleaned_avg_scale_fig2c)=41, lsize(dat6082_dot_cleaned_avg_scale_fig2c)=1, rgb(dat6082_dot_cleaned_avg_scale_fig2c)=(65535,0,0), mrkThick(dat6082_dot_cleaned_avg_scale_fig2c)=0.5, zmrkSize(dat6082_dot_cleaned_avg_scale_fig2c)={$marker_size,*,*,0.01,3}
	
	// modify gfits
	ModifyGraph /W=paper_figure_2c mode(gfit_dat6079_dot_cleaned_avg_scale_fig2c)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale_fig2c)=1, rgb(gfit_dat6079_dot_cleaned_avg_scale_fig2c)=(0,0,0,49151) // (0,0,65535)
	ModifyGraph /W=paper_figure_2c mode(gfit_dat6088_dot_cleaned_avg_scale_fig2c)=0, lsize(gfit_dat6088_dot_cleaned_avg_scale_fig2c)=1, rgb(gfit_dat6088_dot_cleaned_avg_scale_fig2c)=(0,0,0,49151) // (29524,1,58982)
	ModifyGraph /W=paper_figure_2c mode(gfit_dat6085_dot_cleaned_avg_scale_fig2c)=0, lsize(gfit_dat6085_dot_cleaned_avg_scale_fig2c)=1, rgb(gfit_dat6085_dot_cleaned_avg_scale_fig2c)=(0,0,0,49151) // (64981,37624,14500)
	ModifyGraph /W=paper_figure_2c mode(gfit_dat6082_dot_cleaned_avg_scale_fig2c)=0, lsize(gfit_dat6082_dot_cleaned_avg_scale_fig2c)=1, rgb(gfit_dat6082_dot_cleaned_avg_scale_fig2c)=(0,0,0,49151) // (65535,0,0)
	
	Label /W=paper_figure_2c left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"

//	Legend /W=paper_figure_2c /C/N=text0/J/F=0 "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig2c) 22.5 mK\r\\s(gfit_dat6088_dot_cleaned_avg_scale_fig2c) 100 mK\r\\s(gfit_dat6085_dot_cleaned_avg_scale_fig2c) 300 mK\r\\s(gfit_dat6082_dot_cleaned_avg_scale_fig2c) 500 mK"
	Legend /W=paper_figure_2c /C/N=text0/J/F=0 "\\Zr080\\s(dat6079_dot_cleaned_avg_scale_fig2c) 22.5 mK\r\\s(dat6088_dot_cleaned_avg_scale_fig2c) 100 mK\r\\s(dat6085_dot_cleaned_avg_scale_fig2c) 300 mK\r\\s(dat6082_dot_cleaned_avg_scale_fig2c) 500 mK"

//	SetAxis /W=paper_figure_2c bottom -10,10
//	ModifyGraph /W=paper_figure_2c muloffset={0.005,0}
	
	beautify_figure("paper_figure_2c")

endmacro


macro paper_v2_figure_3a()
// data from summer cool down
// base temp
//Datnum 6079 6080 6081


	Display; KillWindow /Z paper_figure_3a; DoWindow/C/O paper_figure_3a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale_fig3a
	duplicate /o dat6080_dot_cleaned_avg_interp dat6080_dot_cleaned_avg_scale_fig3a
	duplicate /o dat6081_dot_cleaned_avg_interp dat6081_dot_cleaned_avg_scale_fig3a
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat6080_dot_cleaned_avg_interp gfit_dat6080_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat6081_dot_cleaned_avg_interp gfit_dat6081_dot_cleaned_avg_scale_fig3a
//	duplicate /o gfit_dat6079_dot_cleaned_avg gfit_dat6079_dot_cleaned_avg_scale_fig3a
//	duplicate /o gfit_dat6080_dot_cleaned_avg gfit_dat6080_dot_cleaned_avg_scale_fig3a
//	duplicate /o gfit_dat6081_dot_cleaned_avg gfit_dat6081_dot_cleaned_avg_scale_fig3a
	
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat6080_dot_cleaned_avg_interp gfit_dat6080_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat6081_dot_cleaned_avg_interp gfit_dat6081_dot_cleaned_avg_scale_fig3a
	
	duplicate /o fit_dat6079_cs_cleaned_avg_occ_interp fit_dat6079_cs_cleaned_avg_occ_interp_fig3a
	duplicate /o fit_dat6080_cs_cleaned_avg_occ_interp fit_dat6080_cs_cleaned_avg_occ_interp_fig3a
	duplicate /o fit_dat6081_cs_cleaned_avg_occ_interp fit_dat6081_cs_cleaned_avg_occ_interp_fig3a
	
	// Scale the fit waves by leverarm and mid point
	// scaling conductance fits
	create_x_wave(gfit_dat6079_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[0]+coef_dat6079_cs_cleaned_avg[2], 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6079_cs_cleaned_avg[2], gfit_dat6079_dot_cleaned_avg_scale_fig3a

	create_x_wave(gfit_dat6080_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat6080_cs_cleaned_avg[1]*x_wave[0]+coef_dat6080_cs_cleaned_avg[2], 1/coef_dat6080_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6080_cs_cleaned_avg[2], gfit_dat6080_dot_cleaned_avg_scale_fig3a

	create_x_wave(gfit_dat6081_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat6081_cs_cleaned_avg[1]*x_wave[0]+coef_dat6081_cs_cleaned_avg[2], 1/coef_dat6081_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6081_cs_cleaned_avg[2], gfit_dat6081_dot_cleaned_avg_scale_fig3a


	// scaling occupation fits
	create_x_wave(fit_dat6079_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[0]+coef_dat6079_cs_cleaned_avg[2], 1/coef_dat6079_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6079_cs_cleaned_avg[2], fit_dat6079_cs_cleaned_avg_occ_interp_fig3a

	create_x_wave(fit_dat6080_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat6080_cs_cleaned_avg[1]*x_wave[0]+coef_dat6080_cs_cleaned_avg[2], 1/coef_dat6080_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6080_cs_cleaned_avg[2], fit_dat6080_cs_cleaned_avg_occ_interp_fig3a

	create_x_wave(fit_dat6081_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat6081_cs_cleaned_avg[1]*x_wave[0]+coef_dat6081_cs_cleaned_avg[2], 1/coef_dat6081_cs_cleaned_avg[1]*x_wave[inf]+coef_dat6081_cs_cleaned_avg[2], fit_dat6081_cs_cleaned_avg_occ_interp_fig3a

	
	
	
	
	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
//		///// translate data
	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale_fig3a, dat6079_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat6080_dot_cleaned_avg_scale_fig3a, dat6080_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat6081_dot_cleaned_avg_scale_fig3a, dat6081_cs_cleaned_avg_occ_interp) 

//	///// translate fit
//	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale_fig3a, fit_dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6080_dot_cleaned_avg_scale_fig3a, fit_dat6080_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6081_dot_cleaned_avg_scale_fig3a, fit_dat6081_cs_cleaned_avg_occ_interp) 
	
		///// translate fit
	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale_fig3a, fit_dat6079_cs_cleaned_avg_occ_interp_fig3a) 
	translate_wave_by_occupation(gfit_dat6080_dot_cleaned_avg_scale_fig3a, fit_dat6080_cs_cleaned_avg_occ_interp_fig3a) 
	translate_wave_by_occupation(gfit_dat6081_dot_cleaned_avg_scale_fig3a, fit_dat6081_cs_cleaned_avg_occ_interp_fig3a) 

	///// append data
	AppendToGraph /W=paper_figure_3a dat6079_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_3a dat6080_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_3a dat6081_dot_cleaned_avg_scale_fig3a; 
	
	///// append gfits
//	AppendToGraph /W=paper_figure_3a gfit_dat6079_dot_cleaned_avg_scale_fig3a;
//	AppendToGraph /W=paper_figure_3a gfit_dat6080_dot_cleaned_avg_scale_fig3a; 
//	AppendToGraph /W=paper_figure_3a gfit_dat6081_dot_cleaned_avg_scale_fig3a; 
	
	
	Label /W=paper_figure_3a bottom "Sweepgate  (mV)"
	ModifyGraph /W=paper_figure_3a muloffset={0.005,0}
//	////////////////////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_3a dat6079_dot_cleaned_avg_scale_fig3a vs dat6079_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a dat6080_dot_cleaned_avg_scale_fig3a vs dat6080_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a dat6081_dot_cleaned_avg_scale_fig3a vs dat6081_cs_cleaned_avg_occ_interp; 
//	
//	///// append gfits
//	AppendToGraph /W=paper_figure_3a gfit_dat6079_dot_cleaned_avg_scale_fig3a vs fit_dat6079_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_3a gfit_dat6080_dot_cleaned_avg_scale_fig3a vs fit_dat6080_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3a gfit_dat6081_dot_cleaned_avg_scale_fig3a vs fit_dat6081_cs_cleaned_avg_occ_interp; 
//	Label /W=paper_figure_3a bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data	
	marker_size = "dat6079_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat6079_dot_cleaned_avg_scale_fig3a, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3a mode(dat6079_dot_cleaned_avg_scale_fig3a)=3, marker(dat6079_dot_cleaned_avg_scale_fig3a)=41, lsize(dat6079_dot_cleaned_avg_scale_fig3a)=1, rgb(dat6079_dot_cleaned_avg_scale_fig3a)=(52685,33924,12336), mrkThick(dat6079_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat6079_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3} 


	marker_size = "dat6080_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat6080_dot_cleaned_avg_scale_fig3a, 10, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3a mode(dat6080_dot_cleaned_avg_scale_fig3a)=3, marker(dat6080_dot_cleaned_avg_scale_fig3a)=41, lsize(dat6080_dot_cleaned_avg_scale_fig3a)=1, rgb(dat6080_dot_cleaned_avg_scale_fig3a)=(24158,34695,23901), mrkThick(dat6080_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat6080_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3} 

	
	marker_size = "dat6081_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat6081_dot_cleaned_avg_scale_fig3a, 10, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3a mode(dat6081_dot_cleaned_avg_scale_fig3a)=3, marker(dat6081_dot_cleaned_avg_scale_fig3a)=41, lsize(dat6081_dot_cleaned_avg_scale_fig3a)=1, rgb(dat6081_dot_cleaned_avg_scale_fig3a)=(0,0,0), mrkThick(dat6081_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat6081_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3}

	
	// modify gfits
//	ModifyGraph /W=paper_figure_3a mode(gfit_dat6079_dot_cleaned_avg_scale_fig3a)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat6079_dot_cleaned_avg_scale_fig3a)=(52685,33924,12336,49151)
//	ModifyGraph /W=paper_figure_3a mode(gfit_dat6080_dot_cleaned_avg_scale_fig3a)=0, lsize(gfit_dat6080_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat6080_dot_cleaned_avg_scale_fig3a)=(24158,34695,23901,49151)
//	ModifyGraph /W=paper_figure_3a mode(gfit_dat6081_dot_cleaned_avg_scale_fig3a)=0, lsize(gfit_dat6081_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat6081_dot_cleaned_avg_scale_fig3a)=(0,0,0,49151)
	
	Label /W=paper_figure_3a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Legend /W=paper_figure_3a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(dat6079_dot_cleaned_avg_scale_fig3a) Γ/T = 19.3\r\\s(dat6080_dot_cleaned_avg_scale_fig3a) Γ/T = 7.24\r\\s(dat6081_dot_cleaned_avg_scale_fig3a) Γ/T = 0.77"
//	Legend /W=paper_figure_3a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig3a) Γ/T = 24.29\r\\s(gfit_dat6080_dot_cleaned_avg_scale_fig3a) Γ/T = 9.48\r\\s(gfit_dat6081_dot_cleaned_avg_scale_fig3a) Γ/T = 0.99"

	Label /W=paper_figure_3a bottom "Sweepgate (w.r.t N = 0.5) (mV)"
	
//	ModifyGraph /W=paper_figure_3a muloffset={0.005,0}
	SetAxis /W=paper_figure_3a bottom -5,5
	beautify_figure("paper_figure_3a")

endmacro

	

macro paper_v2_figure_3b()
// entropy 1281 1282 1283 1284

	Display; KillWindow /Z paper_figure_3b; DoWindow/C/O paper_figure_3b 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled_fig3b
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b
	
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
	dat1281_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1281_numerical_entropy_avg_interp[0]
	dat1282_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1282_numerical_entropy_avg_interp[0]
	dat1283_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1283_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1281_numerical_entropy_avg_interp[0]
	fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1282_numerical_entropy_avg_interp[0]
	fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1283_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	// scale everything by the maximum fit value
//	dat1281_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
//	dat1282_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
//	dat1283_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
//	dat1284_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
//	
//	fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
//	fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
//	fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
//	fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	
	
//	// offset everything
	
	
//	resampleWave(dat1281_numerical_entropy_avg_interp_scaled_fig3b, 500, measure_freq=12195/4)
//	resampleWave(dat1282_numerical_entropy_avg_interp_scaled_fig3b, 500, measure_freq=12195/4)
//	resampleWave(dat1283_numerical_entropy_avg_interp_scaled_fig3b, 500, measure_freq=12195/4)
//	resampleWave(dat1284_numerical_entropy_avg_interp_scaled_fig3b, 500, measure_freq=12195/4)
	
	smooth 1000, dat1281_numerical_entropy_avg_interp_scaled_fig3b
	smooth 1000, dat1282_numerical_entropy_avg_interp_scaled_fig3b
	smooth 1000, dat1283_numerical_entropy_avg_interp_scaled_fig3b
	smooth 2000, dat1284_numerical_entropy_avg_interp_scaled_fig3b
	
	////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	
//	/////// sweepgate //////
	///// translate data
	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_scaled_fig3b, dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_scaled_fig3b, dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_scaled_fig3b, dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_scaled_fig3b, dat1284_cs_cleaned_avg_occ_interp) 

	///// translate fit
	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b, fit_dat1281_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b, fit_dat1282_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b, fit_dat1283_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b, fit_dat1284_cs_cleaned_avg_occ_interp) 
	///// append data
	AppendToGraph /W=paper_figure_3b dat1281_numerical_entropy_avg_interp_scaled_fig3b
	AppendToGraph /W=paper_figure_3b dat1282_numerical_entropy_avg_interp_scaled_fig3b
	AppendToGraph /W=paper_figure_3b dat1283_numerical_entropy_avg_interp_scaled_fig3b
	AppendToGraph /W=paper_figure_3b dat1284_numerical_entropy_avg_interp_scaled_fig3b
	
	ModifyGraph /W=paper_figure_3b muloffset(dat1281_numerical_entropy_avg_interp_scaled_fig3b)={0.005,1/wavemax(dat1281_numerical_entropy_avg_interp_scaled_fig3b)}
	ModifyGraph /W=paper_figure_3b muloffset(dat1282_numerical_entropy_avg_interp_scaled_fig3b)={0.005,1/wavemax(dat1282_numerical_entropy_avg_interp_scaled_fig3b)}
	ModifyGraph /W=paper_figure_3b muloffset(dat1283_numerical_entropy_avg_interp_scaled_fig3b)={0.005,1/wavemax(dat1283_numerical_entropy_avg_interp_scaled_fig3b)}
	ModifyGraph /W=paper_figure_3b muloffset(dat1284_numerical_entropy_avg_interp_scaled_fig3b)={0.005,1/wavemax(dat1284_numerical_entropy_avg_interp_scaled_fig3b)}
	
//	ModifyGraph /W=paper_figure_3b offset(dat1281_numerical_entropy_avg_interp_scaled_fig3b)={0,0}
//	ModifyGraph /W=paper_figure_3b offset(dat1282_numerical_entropy_avg_interp_scaled_fig3b)={0,1}
//	ModifyGraph /W=paper_figure_3b offset(dat1283_numerical_entropy_avg_interp_scaled_fig3b)={0,2}
//	ModifyGraph /W=paper_figure_3b offset(dat1284_numerical_entropy_avg_interp_scaled_fig3b)={0,3}
//	
	///// append fits
//	AppendToGraph /W=paper_figure_3b fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b
//	AppendToGraph /W=paper_figure_3b fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b
//	AppendToGraph /W=paper_figure_3b fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b
//	AppendToGraph /W=paper_figure_3b fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b
	
	Label /W=paper_figure_3b bottom "Sweepgate (w.r.t N = 0.5) (mV)"
	
	
//	// offset 
	variable offset = 0
	variable const_offset = 0
	ModifyGraph /W=paper_figure_3b offset(dat1281_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1282_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1283_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 2 + const_offset}
	ModifyGraph /W=paper_figure_3b offset(dat1284_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 3 + const_offset}
	
//	ModifyGraph /W=paper_figure_3b offset(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 0 + const_offset}
//	ModifyGraph /W=paper_figure_3b offset(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 1 + const_offset}
//	ModifyGraph /W=paper_figure_3b offset(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 2 + const_offset}
//	ModifyGraph /W=paper_figure_3b offset(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b)={0,offset * 3 + const_offset}
	
	
	
	///// adding inset
	///// translate data
//	translate_wave_by_occupation(dat1281_numerical_entropy_avg_interp_noscaled, dat1281_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat1282_numerical_entropy_avg_interp_noscaled, dat1282_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat1283_numerical_entropy_avg_interp_noscaled, dat1283_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat1284_numerical_entropy_avg_interp_noscaled, dat1284_cs_cleaned_avg_occ_interp) 
//
//	///// translate fit
//	translate_wave_by_occupation(fit_dat1281_numerical_entropy_avg_interp_noscaled, fit_dat1281_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(fit_dat1282_numerical_entropy_avg_interp_noscaled, fit_dat1282_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(fit_dat1283_numerical_entropy_avg_interp_noscaled, fit_dat1283_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(fit_dat1284_numerical_entropy_avg_interp_noscaled, fit_dat1284_cs_cleaned_avg_occ_interp) 

//	///// append data
	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled

	ModifyGraph /W=paper_figure_3b rgb(dat1281_numerical_entropy_avg_interp_noscaled)=(0,0,0)
	ModifyGraph /W=paper_figure_3b rgb(dat1284_numerical_entropy_avg_interp_noscaled)=(47802,0,2056)
	
	
	ModifyGraph /W=paper_figure_3b muloffset(dat1281_numerical_entropy_avg_interp_noscaled)={0.005,0},muloffset(dat1284_numerical_entropy_avg_interp_noscaled)={0.005,0}
	SetAxis /W=paper_figure_3b b1 -5,5
	ModifyGraph /W=paper_figure_3b  axisEnab(l1)={0.55,0.95},axisEnab(b1)={0.05,0.35},freePos(l1)={-5,b1},freePos(b1)={0,l1}
	
	//////////////////////////// occupation ///////////////////////////
//	///// append data
//	AppendToGraph /W=paper_figure_3b dat1281_numerical_entropy_avg_interp_scaled_fig3b vs dat1281_cs_cleaned_avg_occ_interp;  
//	AppendToGraph /W=paper_figure_3b dat1282_numerical_entropy_avg_interp_scaled_fig3b vs dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b dat1283_numerical_entropy_avg_interp_scaled_fig3b vs dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b dat1284_numerical_entropy_avg_interp_scaled_fig3b vs dat1284_cs_cleaned_avg_occ_interp;  
//	
//	///// append fits
//	AppendToGraph /W=paper_figure_3b fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b vs fit_dat1281_cs_cleaned_avg_occ_interp;
//	AppendToGraph /W=paper_figure_3b fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b vs fit_dat1282_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b vs fit_dat1283_cs_cleaned_avg_occ_interp; 
//	AppendToGraph /W=paper_figure_3b fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b vs fit_dat1284_cs_cleaned_avg_occ_interp;
//	
//	Label /W=paper_figure_3b bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	
	string marker_size

	// modify data
	marker_size = "dat1281_numerical_entropy_avg_interp_scaled_fig3b" + "_marker_size"; create_marker_size(dat1281_numerical_entropy_avg_interp_scaled_fig3b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3b mode(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=3, marker(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=41, lsize(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=(0,0,0), mrkThick(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=1, zmrkSize(dat1281_numerical_entropy_avg_interp_scaled_fig3b)={$marker_size,*,*,0.01,3} 

	marker_size = "dat1282_numerical_entropy_avg_interp_scaled_fig3b" + "_marker_size"; create_marker_size(dat1282_numerical_entropy_avg_interp_scaled_fig3b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3b mode(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=3, marker(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=41, lsize(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=(24158,34695,23901), mrkThick(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=1, zmrkSize(dat1282_numerical_entropy_avg_interp_scaled_fig3b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1283_numerical_entropy_avg_interp_scaled_fig3b" + "_marker_size"; create_marker_size(dat1283_numerical_entropy_avg_interp_scaled_fig3b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3b mode(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=3, marker(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=41, lsize(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=(52685,33924,12336), mrkThick(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=1, zmrkSize(dat1283_numerical_entropy_avg_interp_scaled_fig3b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1284_numerical_entropy_avg_interp_scaled_fig3b" + "_marker_size"; create_marker_size(dat1284_numerical_entropy_avg_interp_scaled_fig3b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_3b mode(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=3, marker(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=41, lsize(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=(47802,0,2056), mrkThick(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=1, zmrkSize(dat1284_numerical_entropy_avg_interp_scaled_fig3b)={$marker_size,*,*,0.01,3} 

//	ModifyGraph /W=paper_figure_3b mode(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled_fig3b)=(0,0,0)
//	ModifyGraph /W=paper_figure_3b mode(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_3b mode(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=(52685,33924,12336)
//	ModifyGraph /W=paper_figure_3b mode(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled_fig3b)=(47802,0,2056)
	
	// modify fits
//	ModifyGraph /W=paper_figure_3b mode(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b)=0, lsize(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b)=2, rgb(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b)=(0,0,0)
//	ModifyGraph /W=paper_figure_3b mode(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b)=0, lsize(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b)=2, rgb(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_3b mode(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b)=0, lsize(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b)=2, rgb(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b)=(52685,33924,12336)
//	ModifyGraph /W=paper_figure_3b mode(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b)=2, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b)=(47802,0,2056)
		
	
	Label /W=paper_figure_3b left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_3b")
	
//	
//		///// append data
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1283_numerical_entropy_avg_interp_noscaled
//	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 dat1284_numerical_entropy_avg_interp_noscaled
//	
//	///// append fits
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1281_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1282_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1283_numerical_entropy_avg_interp_noscaled
////	AppendToGraph /W=paper_figure_3b /l=l1 /b=b1 fit_dat1284_numerical_entropy_avg_interp_noscaled
//	
//	
//	ModifyGraph /W=paper_figure_3b mode(dat1281_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1281_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1281_numerical_entropy_avg_interp_noscaled)=(0,0,0)
////	ModifyGraph /W=paper_figure_3b mode(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled_fig3b)=(24158,34695,23901)
////	ModifyGraph /W=paper_figure_3b mode(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled_fig3b)=(52685,33924,12336)
//	ModifyGraph /W=paper_figure_3b mode(dat1284_numerical_entropy_avg_interp_noscaled)=2, lsize(dat1284_numerical_entropy_avg_interp_noscaled)=1, rgb(dat1284_numerical_entropy_avg_interp_noscaled)=(47802,0,2056)
//	
////	ModifyGraph /W=paper_figure_3b  axisEnab(l1)={0.5,0.9},axisEnab(b1)={0.1,0.4},freePos(l1)={-25,b1},freePos(b1)={-0.0021,l1}
////	ModifyGraph /W=paper_figure_3b nticks(l1)=2, nticks(b1)=2, noLabel(l1)=2, axisEnab(l1)={0.58,0.98}, axisEnab(b1)={0.03,0.33}, freePos(l1)={-25,b1}, freePos(b1)={-0.0015,l1}
//	ModifyGraph /W=paper_figure_3b nticks(l1)=2, nticks(b1)=2, noLabel(l1)=2, axisEnab(l1)={0.15,0.55}, axisEnab(b1)={0.03,0.33}, freePos(l1)={-25,b1}, freePos(b1)={-0.0015,l1}

	
//	Legend/W=paper_figure_3b /C/N=text0/J/F=0/A=RB/X=4.50/Y=69.35 "\\Zr080\\s(fit_dat1281_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 0.9\r\\s(fit_dat1282_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 8.8\r\\s(fit_dat1283_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 21.7\r\\s(fit_dat1284_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 30.9"
	Legend/W=paper_figure_3b /C/N=text0/J/F=0/A=RB/X=4.50/Y=69.35 "\\Zr080\\s(dat1281_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 0.9\r\\s(dat1282_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 8.8\r\\s(dat1283_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 21.7\r\\s(dat1284_numerical_entropy_avg_interp_scaled_fig3b) Γ/T = 30.9"

	ModifyGraph /W=paper_figure_3b  mirror=0,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=8, tick=2, gFont="Calibri", gfSize=8
//	ModifyGraph/W=paper_figure_3b muloffset={0.005,0}
	SetAxis /W=paper_figure_3b bottom -5,5
	
	ModifyGraph /W=paper_figure_3b mirror(left)=1,mirror(bottom)=1
	
endmacro




macro paper_v2_figure_4a()
// data from summer cool down
// base temp
//Datnum 6079 6080 6081


	Display; KillWindow /Z paper_figure_4a; DoWindow/C/O paper_figure_4a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale_fig4a
	duplicate /o dat6080_dot_cleaned_avg_interp dat6080_dot_cleaned_avg_scale_fig4a
	duplicate /o dat6081_dot_cleaned_avg_interp dat6081_dot_cleaned_avg_scale_fig4a
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat6080_dot_cleaned_avg_interp gfit_dat6080_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat6081_dot_cleaned_avg_interp gfit_dat6081_dot_cleaned_avg_scale_fig4a
	
	
	
	/////// charge transition //////
	
	
	
	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
////		///// translate data
//	translate_wave_by_occupation(dat6079_dot_cleaned_avg_scale_fig4a, dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6080_dot_cleaned_avg_scale_fig4a, dat6080_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(dat6081_dot_cleaned_avg_scale_fig4a, dat6081_cs_cleaned_avg_occ_interp) 
//
//	///// translate fit
//	translate_wave_by_occupation(gfit_dat6079_dot_cleaned_avg_scale_fig4a, fit_dat6079_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6080_dot_cleaned_avg_scale_fig4a, fit_dat6080_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat6081_dot_cleaned_avg_scale_fig4a, fit_dat6081_cs_cleaned_avg_occ_interp) 
//
//	///// append data
//	AppendToGraph /W=paper_figure_4a dat6079_dot_cleaned_avg_scale_fig4a; 
//	AppendToGraph /W=paper_figure_4a dat6080_dot_cleaned_avg_scale_fig4a; 
//	AppendToGraph /W=paper_figure_4a dat6081_dot_cleaned_avg_scale_fig4a; 
//	
//	///// append gfits
//	AppendToGraph /W=paper_figure_4a gfit_dat6079_dot_cleaned_avg_scale_fig4a;
//	AppendToGraph /W=paper_figure_4a gfit_dat6080_dot_cleaned_avg_scale_fig4a; 
//	AppendToGraph /W=paper_figure_4a gfit_dat6081_dot_cleaned_avg_scale_fig4a; 
//	Label /W=paper_figure_4a bottom "Sweepgate  (mV)"
//	ModifyGraph /W=paper_figure_4a muloffset={0.005,0}
//	////////////////////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4a dat6079_dot_cleaned_avg_scale_fig4a vs dat6079_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a dat6080_dot_cleaned_avg_scale_fig4a vs dat6080_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a dat6081_dot_cleaned_avg_scale_fig4a vs dat6081_cs_cleaned_avg_occ_interp; 
	
	///// append gfits
	AppendToGraph /W=paper_figure_4a gfit_dat6079_dot_cleaned_avg_scale_fig4a vs fit_dat6079_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4a gfit_dat6080_dot_cleaned_avg_scale_fig4a vs fit_dat6080_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a gfit_dat6081_dot_cleaned_avg_scale_fig4a vs fit_dat6081_cs_cleaned_avg_occ_interp; 
	Label /W=paper_figure_4a bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data	
	marker_size = "dat6079_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat6079_dot_cleaned_avg_scale_fig4a, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4a mode(dat6079_dot_cleaned_avg_scale_fig4a)=3, marker(dat6079_dot_cleaned_avg_scale_fig4a)=41, lsize(dat6079_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6079_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336), mrkThick(dat6079_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat6079_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 


	marker_size = "dat6080_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat6080_dot_cleaned_avg_scale_fig4a, 10, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4a mode(dat6080_dot_cleaned_avg_scale_fig4a)=3, marker(dat6080_dot_cleaned_avg_scale_fig4a)=41, lsize(dat6080_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6080_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901), mrkThick(dat6080_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat6080_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 

	
	marker_size = "dat6081_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat6081_dot_cleaned_avg_scale_fig4a, 10, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4a mode(dat6081_dot_cleaned_avg_scale_fig4a)=3, marker(dat6081_dot_cleaned_avg_scale_fig4a)=41, lsize(dat6081_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6081_dot_cleaned_avg_scale_fig4a)=(0,0,0), mrkThick(dat6081_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat6081_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3}


//	// modify data
//	
//	ModifyGraph /W=paper_figure_4a mode(dat6079_dot_cleaned_avg_scale_fig4a)=2, lsize(dat6079_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6079_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336)
//	ModifyGraph /W=paper_figure_4a mode(dat6080_dot_cleaned_avg_scale_fig4a)=2, lsize(dat6080_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6080_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_4a mode(dat6081_dot_cleaned_avg_scale_fig4a)=2, lsize(dat6081_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6081_dot_cleaned_avg_scale_fig4a)=(0,0,0)
//	
	// modify gfits
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336,49151)
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6080_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat6080_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat6080_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901,49151)
	ModifyGraph /W=paper_figure_4a mode(gfit_dat6081_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat6081_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat6081_dot_cleaned_avg_scale_fig4a)=(0,0,0,49151)
	
	Label /W=paper_figure_4a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
//	Legend /W=paper_figure_4a /C/N=text0/J/F=0/A=LT "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig4a) Γ/T = 24.29\r\\s(gfit_dat6080_dot_cleaned_avg_scale_fig4a) Γ/T = 9.48\r\\s(gfit_dat6081_dot_cleaned_avg_scale_fig4a) Γ/T = 0.99"
	Legend /W=paper_figure_4a /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat6079_dot_cleaned_avg_scale_fig4a) Γ/T = 19.3\r\\s(dat6080_dot_cleaned_avg_scale_fig4a) Γ/T = 7.24\r\\s(dat6081_dot_cleaned_avg_scale_fig4a) Γ/T = 0.77"

//	Label /W=paper_figure_4a bottom "Sweepgate (centered by mid) (mV)"
	
//	ModifyGraph /W=paper_figure_4a muloffset={0.005,0}
	SetAxis /W=paper_figure_4a bottom 0,1
	beautify_figure("paper_figure_4a")

endmacro




macro paper_v2_figure_4a_field()
// data from summer cool down
// base temp
//Datnum 6079 6100 6081


	Display; KillWindow /Z paper_figure_4a_field; DoWindow/C/O paper_figure_4a_field 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat6079_dot_cleaned_avg_interp dat6079_dot_cleaned_avg_scale_fig4a
	duplicate /o dat6100_dot_cleaned_avg_interp dat6100_dot_cleaned_avg_scale_fig4a
	
	duplicate /o gfit_dat6079_dot_cleaned_avg_interp gfit_dat6079_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat6100_dot_cleaned_avg_interp gfit_dat6100_dot_cleaned_avg_scale_fig4a
	
	
	
	/////// charge transition //////
	

	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4a_field dat6079_dot_cleaned_avg_scale_fig4a vs dat6079_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4a_field dat6100_dot_cleaned_avg_scale_fig4a vs dat6100_cs_cleaned_avg_occ_interp; 
	
	///// append gfits
	AppendToGraph /W=paper_figure_4a_field gfit_dat6079_dot_cleaned_avg_scale_fig4a vs fit_dat6079_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4a_field gfit_dat6100_dot_cleaned_avg_scale_fig4a vs fit_dat6100_cs_cleaned_avg_occ_interp; 
	Label /W=paper_figure_4a_field bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data	
	marker_size = "dat6079_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat6079_dot_cleaned_avg_scale_fig4a, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4a_field mode(dat6079_dot_cleaned_avg_scale_fig4a)=3, marker(dat6079_dot_cleaned_avg_scale_fig4a)=41, lsize(dat6079_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6079_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336), mrkThick(dat6079_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat6079_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 


	marker_size = "dat6100_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat6100_dot_cleaned_avg_scale_fig4a, 10, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4a_field mode(dat6100_dot_cleaned_avg_scale_fig4a)=3, marker(dat6100_dot_cleaned_avg_scale_fig4a)=41, lsize(dat6100_dot_cleaned_avg_scale_fig4a)=1, rgb(dat6100_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901), mrkThick(dat6100_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat6100_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 


	// modify gfits
	ModifyGraph /W=paper_figure_4a_field mode(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat6079_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336,49151)
	ModifyGraph /W=paper_figure_4a_field mode(gfit_dat6100_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat6100_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat6100_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901,49151)
	
	Label /W=paper_figure_4a_field left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
//	Legend /W=paper_figure_4a_field /C/N=text0/J/F=0/A=LT "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig4a) Γ/T = 24.29\r\\s(gfit_dat6100_dot_cleaned_avg_scale_fig4a) Γ/T = 9.48\r\\s(gfit_dat6081_dot_cleaned_avg_scale_fig4a) Γ/T = 0.99"
	Legend /W=paper_figure_4a_field /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat6079_dot_cleaned_avg_scale_fig4a) Field = 70mT\r\\s(dat6100_dot_cleaned_avg_scale_fig4a) Field = 2000mT"

//	Label /W=paper_figure_4a_field bottom "Sweepgate (centered by mid) (mV)"
	
//	ModifyGraph /W=paper_figure_4a_field muloffset={0.005,0}
	SetAxis /W=paper_figure_4a_field bottom 0,1
	beautify_figure("paper_figure_4a_field")

endmacro


macro paper_v2_figure_4b()
// entropy 1281 1282 1283 1284

	Display; KillWindow /Z paper_figure_4b; DoWindow/C/O paper_figure_4b 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1281_numerical_entropy_avg_interp dat1281_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1282_numerical_entropy_avg_interp dat1282_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1283_numerical_entropy_avg_interp dat1283_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled_fig4b
	
	duplicate /o fit_dat1281_numerical_entropy_avg_interp fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1282_numerical_entropy_avg_interp fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1283_numerical_entropy_avg_interp fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b
	
	
	// offset to 0
	dat1281_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1281_numerical_entropy_avg_interp[0]
	dat1282_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1282_numerical_entropy_avg_interp[0]
	dat1283_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1283_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1281_numerical_entropy_avg_interp[0]
	fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1282_numerical_entropy_avg_interp[0]
	fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1283_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1284_numerical_entropy_avg_interp[0]
	
	// scale everything by the maximum fit value
	dat1281_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1281_numerical_entropy_avg_interp)
	dat1282_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1282_numerical_entropy_avg_interp)
	dat1283_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1283_numerical_entropy_avg_interp)
	dat1284_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	
	variable max_val
	max_val = wavemax(fit_dat1281_numerical_entropy_avg_interp)
	fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1282_numerical_entropy_avg_interp)
	fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1283_numerical_entropy_avg_interp)
	fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1284_numerical_entropy_avg_interp)
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	// offset everything
	variable offset = 1.0
	dat1281_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	dat1282_numerical_entropy_avg_interp_scaled_fig4b += offset * 1
	dat1283_numerical_entropy_avg_interp_scaled_fig4b += offset * 2
	dat1284_numerical_entropy_avg_interp_scaled_fig4b += offset * 3
	
	fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b += offset * 1
	fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b += offset * 2
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b += offset * 3
	
	
//	resampleWave(dat1281_numerical_entropy_avg_interp_scaled_fig4b, 500, measure_freq=12195/4)
//	resampleWave(dat1282_numerical_entropy_avg_interp_scaled_fig4b, 500, measure_freq=12195/4)
//	resampleWave(dat1283_numerical_entropy_avg_interp_scaled_fig4b, 500, measure_freq=12195/4)
//	resampleWave(dat1284_numerical_entropy_avg_interp_scaled_fig4b, 500, measure_freq=12195/4)
	
//	smooth 1000, dat1281_numerical_entropy_avg_interp_scaled_fig4b
	smooth 1000, dat1282_numerical_entropy_avg_interp_scaled_fig4b
	smooth 1000, dat1283_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1284_numerical_entropy_avg_interp_scaled_fig4b
	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4b dat1281_numerical_entropy_avg_interp_scaled_fig4b vs dat1281_cs_cleaned_avg_occ_interp;  
	AppendToGraph /W=paper_figure_4b dat1282_numerical_entropy_avg_interp_scaled_fig4b vs dat1282_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b dat1283_numerical_entropy_avg_interp_scaled_fig4b vs dat1283_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b dat1284_numerical_entropy_avg_interp_scaled_fig4b vs dat1284_cs_cleaned_avg_occ_interp;  
	
	///// append fits
	AppendToGraph /W=paper_figure_4b fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1281_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4b fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1282_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1283_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1284_cs_cleaned_avg_occ_interp;
	
	Label /W=paper_figure_4b bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data
	marker_size = "dat1281_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1281_numerical_entropy_avg_interp_scaled_fig4b, 4, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b mode(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0), mrkThick(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1281_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 

	marker_size = "dat1282_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1282_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b mode(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=(24158,34695,23901), mrkThick(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1282_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1283_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1283_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b mode(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=(52685,33924,12336), mrkThick(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1283_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1284_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1284_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b mode(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056), mrkThick(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1284_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 

	// modify data
//	ModifyGraph /W=paper_figure_4b mode(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=2, lsize(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1281_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0)
//	ModifyGraph /W=paper_figure_4b mode(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=2, lsize(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1282_numerical_entropy_avg_interp_scaled_fig4b)=(24158,34695,23901)
//	ModifyGraph /W=paper_figure_4b mode(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=2, lsize(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1283_numerical_entropy_avg_interp_scaled_fig4b)=(52685,33924,12336)
//	ModifyGraph /W=paper_figure_4b mode(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=2, lsize(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056)
	
	// modify fits
	ModifyGraph /W=paper_figure_4b mode(fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1281_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0,49151)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1282_numerical_entropy_avg_interp_scaled_fig4b)=(24158,34695,23901,49151)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1283_numerical_entropy_avg_interp_scaled_fig4b)=(52685,33924,12336,49151)
	ModifyGraph /W=paper_figure_4b mode(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056,49151)
	
	ModifyGraph /W=paper_figure_4b notation(left)=1,manTick(left)={0,1,0,2},manMinor(left)={0,0}
	
	Label /W=paper_figure_4b left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_4b")
	
	Legend/W=paper_figure_4b /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat1281_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 0.99\r\\s(dat1282_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 9.28\r\\s(dat1283_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 26.70\r\\s(dat1284_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 38.16"
	Legend/W=paper_figure_4b /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat1281_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 0.14\r\\s(dat1282_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 3.81\r\\s(dat1283_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 11.60\r\\s(dat1284_numerical_entropy_avg_interp_scaled_fig4b) Γ/T = 16.79"

//	ModifyGraph /W=paper_figure_4b  mirror=0,nticks=3,axThick=0.5,btLen=3,stLen=2,fsize=14, tick=2, gFont="Calibri", gfSize=14
//	ModifyGraph /W=paper_figure_4b mirror(left)=1,mirror(bottom)=1
//	SetAxis /W=paper_figure_4b bottom -6,9
	
endmacro





macro paper_v3_figure_2a_strong()
// data from summer cool down
//Temp	 22.5 275  500
//Datnum 699  695  691



	Display; KillWindow /Z paper_figure_v3_2a; DoWindow/C/O paper_figure_v3_2a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat699_cs_cleaned_avg dat699_cs_cleaned_avg_scale_fig2a
	duplicate /o dat695_cs_cleaned_avg dat695_cs_cleaned_avg_scale_fig2a
	duplicate /o dat691_cs_cleaned_avg dat691_cs_cleaned_avg_scale_fig2a
	
	duplicate /o fit_dat699_cs_cleaned_avg fit_dat699_cs_cleaned_avg_scale_fig2a
	duplicate /o fit_dat695_cs_cleaned_avg fit_dat695_cs_cleaned_avg_scale_fig2a
	duplicate /o fit_dat691_cs_cleaned_avg fit_dat691_cs_cleaned_avg_scale_fig2a
	
	
	////////// removing linear and quadratic terms /////
	// data
	create_x_wave(dat699_cs_cleaned_avg_scale_fig2a)
	dat699_cs_cleaned_avg_scale_fig2a -= (coef_dat699_cs_cleaned_avg[5]*x_wave[p] + coef_dat699_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat699_cs_cleaned_avg[4]

	create_x_wave(dat695_cs_cleaned_avg_scale_fig2a)
	dat695_cs_cleaned_avg_scale_fig2a -= (coef_dat695_cs_cleaned_avg[5]*x_wave[p] + coef_dat695_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat695_cs_cleaned_avg[4]
	
	create_x_wave(dat691_cs_cleaned_avg_scale_fig2a)
	dat691_cs_cleaned_avg_scale_fig2a -= (coef_dat691_cs_cleaned_avg[5]*x_wave[p] + coef_dat691_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat691_cs_cleaned_avg[4]
	

	
	// fit
	create_x_wave(fit_dat699_cs_cleaned_avg_scale_fig2a)
	fit_dat699_cs_cleaned_avg_scale_fig2a -= (coef_dat699_cs_cleaned_avg[5]*x_wave[p] + coef_dat699_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat699_cs_cleaned_avg[4]
	
	create_x_wave(fit_dat695_cs_cleaned_avg_scale_fig2a)
	fit_dat695_cs_cleaned_avg_scale_fig2a -= (coef_dat695_cs_cleaned_avg[5]*x_wave[p] + coef_dat695_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat695_cs_cleaned_avg[4]
	
	create_x_wave(fit_dat691_cs_cleaned_avg_scale_fig2a)
	fit_dat691_cs_cleaned_avg_scale_fig2a -= (coef_dat691_cs_cleaned_avg[5]*x_wave[p] + coef_dat691_cs_cleaned_avg[6]*x_wave[p]^2) + coef_dat691_cs_cleaned_avg[4]
	

	

	
	
	/////// charge transition //////
	///// append data
	AppendToGraph /W=paper_figure_v3_2a dat699_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_v3_2a dat695_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_v3_2a dat691_cs_cleaned_avg_scale_fig2a; 
	
	///// append fits
	AppendToGraph /W=paper_figure_v3_2a fit_dat699_cs_cleaned_avg_scale_fig2a;
	AppendToGraph /W=paper_figure_v3_2a fit_dat695_cs_cleaned_avg_scale_fig2a; 
	AppendToGraph /W=paper_figure_v3_2a fit_dat691_cs_cleaned_avg_scale_fig2a; 
	
	// offset 
	variable offset = 0.005
	variable const_offset = coef_dat699_cs_cleaned_avg[4]
	ModifyGraph /W=paper_figure_v3_2a offset(dat699_cs_cleaned_avg_scale_fig2a)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_v3_2a offset(dat695_cs_cleaned_avg_scale_fig2a)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_v3_2a offset(dat691_cs_cleaned_avg_scale_fig2a)={0,offset * 2 + const_offset}
	
	ModifyGraph /W=paper_figure_v3_2a offset(fit_dat699_cs_cleaned_avg_scale_fig2a)={0,offset * 0 + const_offset}
	ModifyGraph /W=paper_figure_v3_2a offset(fit_dat695_cs_cleaned_avg_scale_fig2a)={0,offset * 1 + const_offset}
	ModifyGraph /W=paper_figure_v3_2a offset(fit_dat691_cs_cleaned_avg_scale_fig2a)={0,offset * 2 + const_offset}
	
	
	string marker_size
	// modify data
	marker_size = "dat699_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat699_cs_cleaned_avg_scale_fig2a, 500, min_marker=0.001, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2a mode(dat699_cs_cleaned_avg_scale_fig2a)=3, marker(dat699_cs_cleaned_avg_scale_fig2a)=41, lsize(dat699_cs_cleaned_avg_scale_fig2a)=1, rgb(dat699_cs_cleaned_avg_scale_fig2a)=(0,0,65535), mrkThick(dat699_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat699_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	marker_size = "dat695_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat695_cs_cleaned_avg_scale_fig2a, 300, min_marker=0.001, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2a mode(dat695_cs_cleaned_avg_scale_fig2a)=3, marker(dat695_cs_cleaned_avg_scale_fig2a)=41, lsize(dat695_cs_cleaned_avg_scale_fig2a)=1, rgb(dat695_cs_cleaned_avg_scale_fig2a)=(64981,37624,14500), mrkThick(dat695_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat695_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	
	marker_size = "dat691_cs_cleaned_avg_scale_fig2a" + "_marker_size"; create_marker_size(dat691_cs_cleaned_avg_scale_fig2a, 300, min_marker=0.001, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2a mode(dat691_cs_cleaned_avg_scale_fig2a)=3, marker(dat691_cs_cleaned_avg_scale_fig2a)=41, lsize(dat691_cs_cleaned_avg_scale_fig2a)=1, rgb(dat691_cs_cleaned_avg_scale_fig2a)=(65535,0,0), mrkThick(dat691_cs_cleaned_avg_scale_fig2a)=0.5, zmrkSize(dat691_cs_cleaned_avg_scale_fig2a)={$marker_size,*,*,0.01,3} 	
	

	// modify fits
	ModifyGraph /W=paper_figure_v3_2a mode(fit_dat699_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat699_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat699_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (0,0,65535)
	ModifyGraph /W=paper_figure_v3_2a mode(fit_dat695_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat695_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat695_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (29524,1,58982)
	ModifyGraph /W=paper_figure_v3_2a mode(fit_dat691_cs_cleaned_avg_scale_fig2a)=0, lsize(fit_dat691_cs_cleaned_avg_scale_fig2a)=1, rgb(fit_dat691_cs_cleaned_avg_scale_fig2a)=(0,0,0,49151) // (64981,37624,14500)
	
	Label /W=paper_figure_v3_2a left "Current (nA)"
	SetAxis /W=paper_figure_v3_2a bottom -10,10

	Label /W=paper_figure_v3_2a bottom "Sweepgate  (mV)"
	
	beautify_figure("paper_figure_v3_2a")
	
	
	AppendToGraph /W=paper_figure_v3_2a /l=l1 /b=b1, dat691_cs_cleaned_avg
	
	ModifyGraph /W=paper_figure_v3_2a muloffset={0.005,0}
	
	ModifyGraph /W=paper_figure_v3_2a axisEnab(l1)={0.2,0.55},axisEnab(b1)={0.15,0.5},freePos(l1)={-40,b1},freePos(b1)={0,l1}
	SetAxis /W=paper_figure_v3_2a b1 -25,25
	SetAxis /W=paper_figure_v3_2a left 1.015,1.075
	
	Legend /W=paper_figure_v3_2a /C/N=text0/J/F=0/F=0 "\\Zr080\\s(dat699_cs_cleaned_avg_scale_fig2a) 22.5 mK\r\\s(dat695_cs_cleaned_avg_scale_fig2a) 275 mK\r\\s(dat691_cs_cleaned_avg_scale_fig2a) 500 mK"


endmacro


macro paper_v3_figure_2b_strong()
// data from summer cool down
//Temp	 22.5  275  500
//Datnum 699  695  691


// charge transition
//dat1293_cs_cleaned_avg
//GFit_dat1289_cs_cleaned_avg

// occupation 
//dat1289_cs_cleaned_avg_occ
//Gfit_dat1297_cs_cleaned_avg_occ

	Display; KillWindow /Z paper_figure_v3_2b; DoWindow/C/O paper_figure_v3_2b 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat699_dot_cleaned_avg_interp dat699_dot_cleaned_avg_scale_fig2b
	duplicate /o dat695_dot_cleaned_avg_interp dat695_dot_cleaned_avg_scale_fig2b
	duplicate /o dat691_dot_cleaned_avg_interp dat691_dot_cleaned_avg_scale_fig2b
	
	duplicate /o gfit_dat699_dot_cleaned_avg_interp gfit_dat699_dot_cleaned_avg_scale_fig2b
	duplicate /o gfit_dat695_dot_cleaned_avg_interp gfit_dat695_dot_cleaned_avg_scale_fig2b
	duplicate /o gfit_dat691_dot_cleaned_avg_interp gfit_dat691_dot_cleaned_avg_scale_fig2b
	

	
	
	///// append data
	AppendToGraph /W=paper_figure_v3_2b dat699_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_v3_2b dat695_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_v3_2b dat691_dot_cleaned_avg_scale_fig2b; 
	
		///// append gfits
	AppendToGraph /W=paper_figure_v3_2b gfit_dat699_dot_cleaned_avg_scale_fig2b;
	AppendToGraph /W=paper_figure_v3_2b gfit_dat695_dot_cleaned_avg_scale_fig2b; 
	AppendToGraph /W=paper_figure_v3_2b gfit_dat691_dot_cleaned_avg_scale_fig2b;
	
	
	Label /W=paper_figure_v3_2b bottom "Sweepgate  (mV)"
	
	
	string marker_size
	// modify data
	marker_size = "dat699_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat699_dot_cleaned_avg_scale_fig2b, 200, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2b mode(dat699_dot_cleaned_avg_scale_fig2b)=3, marker(dat699_dot_cleaned_avg_scale_fig2b)=41, lsize(dat699_dot_cleaned_avg_scale_fig2b)=1, rgb(dat699_dot_cleaned_avg_scale_fig2b)=(0,0,65535), mrkThick(dat699_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat699_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3} 
	
	marker_size = "dat695_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat695_dot_cleaned_avg_scale_fig2b, 300, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2b mode(dat695_dot_cleaned_avg_scale_fig2b)=3, marker(dat695_dot_cleaned_avg_scale_fig2b)=41, lsize(dat695_dot_cleaned_avg_scale_fig2b)=1, rgb(dat695_dot_cleaned_avg_scale_fig2b)=(29524,1,58982), mrkThick(dat695_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat695_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3} 
	

	marker_size = "dat691_dot_cleaned_avg_scale_fig2b" + "_marker_size"; create_marker_size(dat691_dot_cleaned_avg_scale_fig2b, 300, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_2b mode(dat691_dot_cleaned_avg_scale_fig2b)=3, marker(dat691_dot_cleaned_avg_scale_fig2b)=41, lsize(dat691_dot_cleaned_avg_scale_fig2b)=1, rgb(dat691_dot_cleaned_avg_scale_fig2b)=(65535,0,0), mrkThick(dat691_dot_cleaned_avg_scale_fig2b)=0.5, zmrkSize(dat691_dot_cleaned_avg_scale_fig2b)={$marker_size,*,*,0.01,3}
	
	// modify gfits
	ModifyGraph /W=paper_figure_v3_2b mode(gfit_dat699_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat699_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat699_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (0,0,65535)
	ModifyGraph /W=paper_figure_v3_2b mode(gfit_dat695_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat695_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat695_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (29524,1,58982)
	ModifyGraph /W=paper_figure_v3_2b mode(gfit_dat691_dot_cleaned_avg_scale_fig2b)=0, lsize(gfit_dat691_dot_cleaned_avg_scale_fig2b)=1, rgb(gfit_dat691_dot_cleaned_avg_scale_fig2b)=(0,0,0,49151) // (65535,0,0)
	
	Label /W=paper_figure_v3_2b left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"

//	Legend /W=paper_figure_v3_2b /C/N=text0/J/F=0 "\\Zr080\\s(gfit_dat6079_dot_cleaned_avg_scale_fig2b) 22.5 mK\r\\s(gfit_dat6088_dot_cleaned_avg_scale_fig2b) 100 mK\r\\s(gfit_dat6085_dot_cleaned_avg_scale_fig2b) 300 mK\r\\s(gfit_dat691_dot_cleaned_avg_scale_fig2b) 500 mK"
	Legend /W=paper_figure_v3_2b /C/N=text0/J/F=0 "\\Zr080\\s(dat699_dot_cleaned_avg_scale_fig2b) 22.5 mK\r\\s(dat695_dot_cleaned_avg_scale_fig2b) 275 mK\r\\s(dat691_dot_cleaned_avg_scale_fig2b) 500 mK"

	SetAxis /W=paper_figure_v3_2b bottom -10,10
	ModifyGraph /W=paper_figure_v3_2b muloffset={0.005,0}
	
	beautify_figure("paper_figure_v3_2b")

endmacro




macro paper_v3_figure_3a()
// data from autumn cool down
// base temp
// 699 698, 697, 696

	Display; KillWindow /Z paper_figure_v3_3a; DoWindow/C/O paper_figure_v3_3a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat699_dot_cleaned_avg_interp dat699_dot_cleaned_avg_scale_fig3a
	duplicate /o dat698_dot_cleaned_avg_interp dat698_dot_cleaned_avg_scale_fig3a
	duplicate /o dat697_dot_cleaned_avg_interp dat697_dot_cleaned_avg_scale_fig3a
	duplicate /o dat696_dot_cleaned_avg_interp dat696_dot_cleaned_avg_scale_fig3a

	
	duplicate /o gfit_dat699_dot_cleaned_avg_interp gfit_dat699_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat698_dot_cleaned_avg_interp gfit_dat698_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat697_dot_cleaned_avg_interp gfit_dat697_dot_cleaned_avg_scale_fig3a
	duplicate /o gfit_dat696_dot_cleaned_avg_interp gfit_dat696_dot_cleaned_avg_scale_fig3a
	
	duplicate /o fit_dat699_cs_cleaned_avg_occ_interp fit_dat699_cs_cleaned_avg_occ_interp_fig3a
	duplicate /o fit_dat698_cs_cleaned_avg_occ_interp fit_dat698_cs_cleaned_avg_occ_interp_fig3a
	duplicate /o fit_dat697_cs_cleaned_avg_occ_interp fit_dat697_cs_cleaned_avg_occ_interp_fig3a
	duplicate /o fit_dat696_cs_cleaned_avg_occ_interp fit_dat696_cs_cleaned_avg_occ_interp_fig3a
	
	// Scale the fit waves by leverarm and mid point
	// scaling conductance fits
	create_x_wave(gfit_dat699_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat699_cs_cleaned_avg[1]*x_wave[0]+coef_dat699_cs_cleaned_avg[2], 1/coef_dat699_cs_cleaned_avg[1]*x_wave[inf]+coef_dat699_cs_cleaned_avg[2], gfit_dat699_dot_cleaned_avg_scale_fig3a

	create_x_wave(gfit_dat698_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat698_cs_cleaned_avg[1]*x_wave[0]+coef_dat698_cs_cleaned_avg[2], 1/coef_dat698_cs_cleaned_avg[1]*x_wave[inf]+coef_dat698_cs_cleaned_avg[2], gfit_dat698_dot_cleaned_avg_scale_fig3a

	create_x_wave(gfit_dat697_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat697_cs_cleaned_avg[1]*x_wave[0]+coef_dat697_cs_cleaned_avg[2], 1/coef_dat697_cs_cleaned_avg[1]*x_wave[inf]+coef_dat697_cs_cleaned_avg[2], gfit_dat697_dot_cleaned_avg_scale_fig3a

	create_x_wave(gfit_dat696_dot_cleaned_avg_scale_fig3a)
	setscale /I x 1/coef_dat696_cs_cleaned_avg[1]*x_wave[0]+coef_dat696_cs_cleaned_avg[2], 1/coef_dat696_cs_cleaned_avg[1]*x_wave[inf]+coef_dat696_cs_cleaned_avg[2], gfit_dat696_dot_cleaned_avg_scale_fig3a

	// scaling occupation fits
	create_x_wave(fit_dat699_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat699_cs_cleaned_avg[1]*x_wave[0]+coef_dat699_cs_cleaned_avg[2], 1/coef_dat699_cs_cleaned_avg[1]*x_wave[inf]+coef_dat699_cs_cleaned_avg[2], fit_dat699_cs_cleaned_avg_occ_interp_fig3a

	create_x_wave(fit_dat698_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat698_cs_cleaned_avg[1]*x_wave[0]+coef_dat698_cs_cleaned_avg[2], 1/coef_dat698_cs_cleaned_avg[1]*x_wave[inf]+coef_dat698_cs_cleaned_avg[2], fit_dat698_cs_cleaned_avg_occ_interp_fig3a

	create_x_wave(fit_dat697_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat697_cs_cleaned_avg[1]*x_wave[0]+coef_dat697_cs_cleaned_avg[2], 1/coef_dat697_cs_cleaned_avg[1]*x_wave[inf]+coef_dat697_cs_cleaned_avg[2], fit_dat697_cs_cleaned_avg_occ_interp_fig3a

	create_x_wave(fit_dat696_cs_cleaned_avg_occ_interp_fig3a)
	setscale /I x 1/coef_dat696_cs_cleaned_avg[1]*x_wave[0]+coef_dat696_cs_cleaned_avg[2], 1/coef_dat696_cs_cleaned_avg[1]*x_wave[inf]+coef_dat696_cs_cleaned_avg[2], fit_dat696_cs_cleaned_avg_occ_interp_fig3a


	
	////////////////////////////////// SWEEPGATE //////////////////////////////////////////////////////////////
//		///// translate data
	translate_wave_by_occupation(dat699_dot_cleaned_avg_scale_fig3a, dat699_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat698_dot_cleaned_avg_scale_fig3a, dat698_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat697_dot_cleaned_avg_scale_fig3a, dat697_cs_cleaned_avg_occ_interp) 
	translate_wave_by_occupation(dat696_dot_cleaned_avg_scale_fig3a, dat696_cs_cleaned_avg_occ_interp) 


//	///// translate fit
//	translate_wave_by_occupation(gfit_dat699_dot_cleaned_avg_scale_fig3a, fit_dat699_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat698_dot_cleaned_avg_scale_fig3a, fit_dat698_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat697_dot_cleaned_avg_scale_fig3a, fit_dat697_cs_cleaned_avg_occ_interp) 
//	translate_wave_by_occupation(gfit_dat696_dot_cleaned_avg_scale_fig3a, fit_dat696_cs_cleaned_avg_occ_interp) 
		///// translate fit
	translate_wave_by_occupation(gfit_dat699_dot_cleaned_avg_scale_fig3a, fit_dat699_cs_cleaned_avg_occ_interp_fig3a) 
	translate_wave_by_occupation(gfit_dat698_dot_cleaned_avg_scale_fig3a, fit_dat698_cs_cleaned_avg_occ_interp_fig3a) 
	translate_wave_by_occupation(gfit_dat697_dot_cleaned_avg_scale_fig3a, fit_dat697_cs_cleaned_avg_occ_interp_fig3a) 
	translate_wave_by_occupation(gfit_dat696_dot_cleaned_avg_scale_fig3a, fit_dat696_cs_cleaned_avg_occ_interp_fig3a) 


	///// append data
	AppendToGraph /W=paper_figure_v3_3a dat699_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a dat698_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a dat697_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a dat696_dot_cleaned_avg_scale_fig3a; 


	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data	
	marker_size = "dat699_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat699_dot_cleaned_avg_scale_fig3a, 100, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_3a mode(dat699_dot_cleaned_avg_scale_fig3a)=3, marker(dat699_dot_cleaned_avg_scale_fig3a)=41, lsize(dat699_dot_cleaned_avg_scale_fig3a)=1, rgb(dat699_dot_cleaned_avg_scale_fig3a)=(47802,0,2056), mrkThick(dat699_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat699_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3} 


	marker_size = "dat698_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat698_dot_cleaned_avg_scale_fig3a, 80, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_3a mode(dat698_dot_cleaned_avg_scale_fig3a)=3, marker(dat698_dot_cleaned_avg_scale_fig3a)=41, lsize(dat698_dot_cleaned_avg_scale_fig3a)=1, rgb(dat698_dot_cleaned_avg_scale_fig3a)=(52685,33924,12336), mrkThick(dat698_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat698_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3} 

	
	marker_size = "dat697_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat697_dot_cleaned_avg_scale_fig3a, 60, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_3a mode(dat697_dot_cleaned_avg_scale_fig3a)=3, marker(dat697_dot_cleaned_avg_scale_fig3a)=41, lsize(dat697_dot_cleaned_avg_scale_fig3a)=1, rgb(dat697_dot_cleaned_avg_scale_fig3a)=(24158,34695,23901), mrkThick(dat697_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat697_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3}

	
	marker_size = "dat696_dot_cleaned_avg_scale_fig3a" + "_marker_size"; create_marker_size(dat696_dot_cleaned_avg_scale_fig3a, 60, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_3a mode(dat696_dot_cleaned_avg_scale_fig3a)=3, marker(dat696_dot_cleaned_avg_scale_fig3a)=41, lsize(dat696_dot_cleaned_avg_scale_fig3a)=1, rgb(dat696_dot_cleaned_avg_scale_fig3a)=(0,0,0), mrkThick(dat696_dot_cleaned_avg_scale_fig3a)=1, zmrkSize(dat696_dot_cleaned_avg_scale_fig3a)={$marker_size,*,*,0.01,3}

		
	// append fit
	AppendToGraph /W=paper_figure_v3_3a gfit_dat699_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a gfit_dat698_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a gfit_dat697_dot_cleaned_avg_scale_fig3a; 
	AppendToGraph /W=paper_figure_v3_3a gfit_dat696_dot_cleaned_avg_scale_fig3a; 
	
	ModifyGraph /W=paper_figure_v3_3a mode(gfit_dat699_dot_cleaned_avg_scale_fig3a)=0,  lsize(gfit_dat699_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat699_dot_cleaned_avg_scale_fig3a)=(0,0,0,32768)
	ModifyGraph /W=paper_figure_v3_3a mode(gfit_dat698_dot_cleaned_avg_scale_fig3a)=0,  lsize(gfit_dat698_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat698_dot_cleaned_avg_scale_fig3a)=(0,0,0,32768)
	ModifyGraph /W=paper_figure_v3_3a mode(gfit_dat697_dot_cleaned_avg_scale_fig3a)=0,  lsize(gfit_dat697_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat697_dot_cleaned_avg_scale_fig3a)=(0,0,0,32768)
	ModifyGraph /W=paper_figure_v3_3a mode(gfit_dat696_dot_cleaned_avg_scale_fig3a)=0,  lsize(gfit_dat696_dot_cleaned_avg_scale_fig3a)=1, rgb(gfit_dat696_dot_cleaned_avg_scale_fig3a)=(0,0,0,32768)

	
	
	
	Label /W=paper_figure_v3_3a bottom "Sweepgate  (mV)"
	ModifyGraph /W=paper_figure_v3_3a muloffset={0.005,0}
	
	Label /W=paper_figure_v3_3a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	

	Legend /W=paper_figure_v3_3a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(dat699_dot_cleaned_avg_scale_fig3a) Γ/T = 27.6\r\\s(dat698_dot_cleaned_avg_scale_fig3a) Γ/T = 19.8\r\\s(dat697_dot_cleaned_avg_scale_fig3a) Γ/T = 7.1\r\\s(dat696_dot_cleaned_avg_scale_fig3a) Γ/T = 3.3"

	Label /W=paper_figure_v3_3a bottom "Sweepgate (w.r.t N = 0.5) (mV)"
	
//	ModifyGraph /W=paper_figure_v3_3a muloffset={0.005,0}
	SetAxis /W=paper_figure_v3_3a bottom -5,5
	beautify_figure("paper_figure_v3_3a")

endmacro





macro paper_v3_figure_4a()
// data from summer cool down
// base temp
// 699 698, 697, 696


	Display; KillWindow /Z paper_figure_v3_4a; DoWindow/C/O paper_figure_v3_4a 
	
	
	///// duplicating so that data can be re-scaled /////
	duplicate /o dat699_dot_cleaned_avg_interp dat699_dot_cleaned_avg_scale_fig4a
	duplicate /o dat698_dot_cleaned_avg_interp dat698_dot_cleaned_avg_scale_fig4a
	duplicate /o dat697_dot_cleaned_avg_interp dat697_dot_cleaned_avg_scale_fig4a
	duplicate /o dat696_dot_cleaned_avg_interp dat696_dot_cleaned_avg_scale_fig4a
	
	duplicate /o gfit_dat699_dot_cleaned_avg_interp gfit_dat699_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat698_dot_cleaned_avg_interp gfit_dat698_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat697_dot_cleaned_avg_interp gfit_dat697_dot_cleaned_avg_scale_fig4a
	duplicate /o gfit_dat696_dot_cleaned_avg_interp gfit_dat696_dot_cleaned_avg_scale_fig4a




	////////////////////////////////// OCCUPATION //////////////////////////////////////////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_v3_4a dat699_dot_cleaned_avg_scale_fig4a vs dat699_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_v3_4a dat698_dot_cleaned_avg_scale_fig4a vs dat698_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_v3_4a dat697_dot_cleaned_avg_scale_fig4a vs dat697_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_v3_4a dat696_dot_cleaned_avg_scale_fig4a vs dat696_cs_cleaned_avg_occ_interp; 

	
	///// append gfits
	AppendToGraph /W=paper_figure_v3_4a gfit_dat699_dot_cleaned_avg_scale_fig4a vs fit_dat699_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_v3_4a gfit_dat698_dot_cleaned_avg_scale_fig4a vs fit_dat698_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_v3_4a gfit_dat697_dot_cleaned_avg_scale_fig4a vs fit_dat697_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_v3_4a gfit_dat696_dot_cleaned_avg_scale_fig4a vs fit_dat696_cs_cleaned_avg_occ_interp; 


	Label /W=paper_figure_v3_4a bottom "Occupation  (.arb)"
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;	14906,27499,34438" // black, green, yellow, red
	string marker_size

	// modify data	
	marker_size = "dat699_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat699_dot_cleaned_avg_scale_fig4a, 300, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_4a mode(dat699_dot_cleaned_avg_scale_fig4a)=3, marker(dat699_dot_cleaned_avg_scale_fig4a)=41, lsize(dat699_dot_cleaned_avg_scale_fig4a)=1, rgb(dat699_dot_cleaned_avg_scale_fig4a)=(47802,0,2056), mrkThick(dat699_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat699_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 


	marker_size = "dat698_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat698_dot_cleaned_avg_scale_fig4a, 200, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_4a mode(dat698_dot_cleaned_avg_scale_fig4a)=3, marker(dat698_dot_cleaned_avg_scale_fig4a)=41, lsize(dat698_dot_cleaned_avg_scale_fig4a)=1, rgb(dat698_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336), mrkThick(dat698_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat698_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3} 

	
	marker_size = "dat697_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat697_dot_cleaned_avg_scale_fig4a, 100, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_4a mode(dat697_dot_cleaned_avg_scale_fig4a)=3, marker(dat697_dot_cleaned_avg_scale_fig4a)=41, lsize(dat697_dot_cleaned_avg_scale_fig4a)=1, rgb(dat697_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901), mrkThick(dat697_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat697_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3}

	marker_size = "dat696_dot_cleaned_avg_scale_fig4a" + "_marker_size"; create_marker_size(dat696_dot_cleaned_avg_scale_fig4a, 50, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_v3_4a mode(dat696_dot_cleaned_avg_scale_fig4a)=3, marker(dat696_dot_cleaned_avg_scale_fig4a)=41, lsize(dat696_dot_cleaned_avg_scale_fig4a)=1, rgb(dat696_dot_cleaned_avg_scale_fig4a)=(0,0,0), mrkThick(dat696_dot_cleaned_avg_scale_fig4a)=1, zmrkSize(dat696_dot_cleaned_avg_scale_fig4a)={$marker_size,*,*,0.01,3}


	// modify gfits
	ModifyGraph /W=paper_figure_v3_4a mode(gfit_dat699_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat699_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat699_dot_cleaned_avg_scale_fig4a)=(47802,0,2056,49151)
	ModifyGraph /W=paper_figure_v3_4a mode(gfit_dat698_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat698_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat698_dot_cleaned_avg_scale_fig4a)=(52685,33924,12336,49151)
	ModifyGraph /W=paper_figure_v3_4a mode(gfit_dat697_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat697_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat697_dot_cleaned_avg_scale_fig4a)=(24158,34695,23901,49151)
	ModifyGraph /W=paper_figure_v3_4a mode(gfit_dat696_dot_cleaned_avg_scale_fig4a)=0, lsize(gfit_dat696_dot_cleaned_avg_scale_fig4a)=1, rgb(gfit_dat696_dot_cleaned_avg_scale_fig4a)=(0,0,0,49151)

	Label /W=paper_figure_v3_4a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	// 22.5mK base temp
//	Legend /W=paper_figure_v3_4a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(dat699_dot_cleaned_avg_scale_fig4a) Γ/T = 27.7\r\\s(dat698_dot_cleaned_avg_scale_fig4a) Γ/T = 19.8\r\\s(dat697_dot_cleaned_avg_scale_fig4a) Γ/T = 7.1\r\\s(dat696_dot_cleaned_avg_scale_fig4a) Γ/T = 3.3"
	// 55mK base temp
	Legend /W=paper_figure_v3_4a /C/N=text0/J/F=0/A=LT/X=73.00/Y=4.51 "\\Zr080\\s(dat699_dot_cleaned_avg_scale_fig4a) Γ/T = 11.8\r\\s(dat698_dot_cleaned_avg_scale_fig4a) Γ/T = 8.16\r\\s(dat697_dot_cleaned_avg_scale_fig4a) Γ/T = 2.4\r\\s(dat696_dot_cleaned_avg_scale_fig4a) Γ/T = 0.87"

	SetAxis /W=paper_figure_v3_4a bottom 0,1

	beautify_figure("paper_figure_v3_4a")

endmacro



macro paper_v2_figure_4b_csbias()
// entropy 1281 1282 1283 1284

// base temp
// 1372 1284 1373 1374 1439
// 50uV 100uV 250uV 500uV 1000uV

	Display; KillWindow /Z paper_figure_4b_csbias; DoWindow/C/O paper_figure_4b_csbias 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1372_numerical_entropy_avg_interp dat1372_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1284_numerical_entropy_avg_interp dat1284_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1373_numerical_entropy_avg_interp dat1373_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1374_numerical_entropy_avg_interp dat1374_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1439_numerical_entropy_avg_interp dat1439_numerical_entropy_avg_interp_scaled_fig4b

	duplicate /o fit_dat1372_numerical_entropy_avg_interp fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1284_numerical_entropy_avg_interp fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1373_numerical_entropy_avg_interp fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1374_numerical_entropy_avg_interp fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1439_numerical_entropy_avg_interp fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b

	
	// offset to 0
	dat1372_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1372_numerical_entropy_avg_interp[0]
	dat1284_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1284_numerical_entropy_avg_interp[0]
	dat1373_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1373_numerical_entropy_avg_interp[0]
	dat1374_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1374_numerical_entropy_avg_interp[0]
	dat1439_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1439_numerical_entropy_avg_interp[0]

	
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1372_numerical_entropy_avg_interp[0]
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1284_numerical_entropy_avg_interp[0]
	fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1373_numerical_entropy_avg_interp[0]
	fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1374_numerical_entropy_avg_interp[0]
	fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1439_numerical_entropy_avg_interp[0]

	
	// scale everything by the maximum fit value
	dat1372_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1372_numerical_entropy_avg_interp)
	dat1284_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1284_numerical_entropy_avg_interp)
	dat1373_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1373_numerical_entropy_avg_interp)
	dat1374_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1374_numerical_entropy_avg_interp)
	dat1439_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1439_numerical_entropy_avg_interp)

	
	variable max_val
	max_val = wavemax(fit_dat1372_numerical_entropy_avg_interp)
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1284_numerical_entropy_avg_interp)
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1373_numerical_entropy_avg_interp)
	fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1374_numerical_entropy_avg_interp)
	fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1439_numerical_entropy_avg_interp)
	fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	
	// offset everything
	variable offset = 0.5
	dat1372_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	dat1284_numerical_entropy_avg_interp_scaled_fig4b += offset * 1
	dat1373_numerical_entropy_avg_interp_scaled_fig4b += offset * 2
	dat1374_numerical_entropy_avg_interp_scaled_fig4b += offset * 3
	dat1439_numerical_entropy_avg_interp_scaled_fig4b += offset * 4
	
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b += offset * 1
	fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b += offset * 2
	fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b += offset * 3
	fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b += offset * 4
	
	
	
	smooth 2000, dat1372_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1284_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1373_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1374_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1439_numerical_entropy_avg_interp_scaled_fig4b
	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4b_csbias dat1372_numerical_entropy_avg_interp_scaled_fig4b vs dat1372_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_csbias dat1284_numerical_entropy_avg_interp_scaled_fig4b vs dat1284_cs_cleaned_avg_occ_interp;   
	AppendToGraph /W=paper_figure_4b_csbias dat1373_numerical_entropy_avg_interp_scaled_fig4b vs dat1373_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_csbias dat1374_numerical_entropy_avg_interp_scaled_fig4b vs dat1374_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_csbias dat1439_numerical_entropy_avg_interp_scaled_fig4b vs dat1439_cs_cleaned_avg_occ_interp;  
	
	///// append fits
	AppendToGraph /W=paper_figure_4b_csbias fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1372_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4b_csbias fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1284_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4b_csbias fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1373_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_csbias fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1374_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_csbias fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1439_cs_cleaned_avg_occ_interp;
	
	Label /W=paper_figure_4b_csbias bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;  14906,27499,34438;	14906,27499,34438 // black, green, yellow, red, blue
	string marker_size

	// modify data
	marker_size = "dat1372_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1372_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_csbias mode(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0), mrkThick(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1372_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 

	marker_size = "dat1284_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1284_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_csbias mode(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056), mrkThick(dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1284_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1373_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1373_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_csbias mode(dat1373_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1373_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1373_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1373_numerical_entropy_avg_interp_scaled_fig4b)=(24158,34695,23901), mrkThick(dat1373_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1373_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1374_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1374_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_csbias mode(dat1374_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1374_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1374_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1374_numerical_entropy_avg_interp_scaled_fig4b)=(52685,33924,12336), mrkThick(dat1374_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1374_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	marker_size = "dat1439_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1439_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_csbias mode(dat1439_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1439_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1439_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1439_numerical_entropy_avg_interp_scaled_fig4b)=(14906,27499,34438), mrkThick(dat1439_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1439_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	// modify fits
	ModifyGraph /W=paper_figure_4b_csbias mode(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0,49151)
	ModifyGraph /W=paper_figure_4b_csbias mode(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1284_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056,49151)
	ModifyGraph /W=paper_figure_4b_csbias mode(fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1373_numerical_entropy_avg_interp_scaled_fig4b)=(24158,34695,23901,49151)
	ModifyGraph /W=paper_figure_4b_csbias mode(fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1374_numerical_entropy_avg_interp_scaled_fig4b)=(52685,33924,12336,49151)
	ModifyGraph /W=paper_figure_4b_csbias mode(fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1439_numerical_entropy_avg_interp_scaled_fig4b)=(14906,27499,34438,49151)
	
	ModifyGraph /W=paper_figure_4b_csbias notation(left)=1,manTick(left)={0,1,0,2},manMinor(left)={0,0}
	
	Label /W=paper_figure_4b_csbias left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_4b_csbias")
	
//	Legend/W=paper_figure_4b_csbias /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat1372_numerical_entropy_avg_interp_scaled_fig4b) bias = 50uV\r\\s(dat1284_numerical_entropy_avg_interp_scaled_fig4b) bias = 100uV\r\\s(dat1373_numerical_entropy_avg_interp_scaled_fig4b) bias = 250uV 1\r\\s(dat1374_numerical_entropy_avg_interp_scaled_fig4b) bias = 500uV\r\\s(dat1439_numerical_entropy_avg_interp_scaled_fig4b) bias = 1000uV"
	Legend/W=paper_figure_4b_csbias /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat1439_numerical_entropy_avg_interp_scaled_fig4b) bias = 1000uV\r\\s(dat1374_numerical_entropy_avg_interp_scaled_fig4b) bias = 500uV\r\\s(dat1373_numerical_entropy_avg_interp_scaled_fig4b) bias = 250uV\r\\s(dat1284_numerical_entropy_avg_interp_scaled_fig4b) bias = 100uV\r\\s(dat1372_numerical_entropy_avg_interp_scaled_fig4b) bias = 50uV"

endmacro



macro paper_v2_figure_4b_symmetric()
// entropy 1281 1282 1283 1284

// base temp
// 1372 1284 1373 1374 1439
// 50uV 100uV 250uV 500uV 1000uV

	Display; KillWindow /Z paper_figure_4b_symmetric; DoWindow/C/O paper_figure_4b_symmetric 
	
	////////////////////////////////////////////////////////////
	//////////// duplicate and scale ///////////////////////////
	////////////////////////////////////////////////////////////
	///// scaled data
	duplicate /o dat1372_numerical_entropy_avg_interp dat1372_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o dat1473_numerical_entropy_avg_interp dat1473_numerical_entropy_avg_interp_scaled_fig4b


	duplicate /o fit_dat1372_numerical_entropy_avg_interp fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b
	duplicate /o fit_dat1473_numerical_entropy_avg_interp fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b


	
	// offset to 0
	dat1372_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1372_numerical_entropy_avg_interp[0]
	dat1473_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1473_numerical_entropy_avg_interp[0]


	
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1372_numerical_entropy_avg_interp[0]
	fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b -= fit_dat1473_numerical_entropy_avg_interp[0]


	
	// scale everything by the maximum fit value
	dat1372_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1372_numerical_entropy_avg_interp)
	dat1473_numerical_entropy_avg_interp_scaled_fig4b /= wavemax(fit_dat1473_numerical_entropy_avg_interp)


	
	variable max_val
	max_val = wavemax(fit_dat1372_numerical_entropy_avg_interp)
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	
	max_val = wavemax(fit_dat1473_numerical_entropy_avg_interp)
	fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b /= max_val
	

	
	
	// offset everything
	variable offset = 0.3
	dat1372_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	dat1473_numerical_entropy_avg_interp_scaled_fig4b += offset * 1

	
	fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b += offset * 0
	fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b += offset * 1

	
	
	
	smooth 2000, dat1372_numerical_entropy_avg_interp_scaled_fig4b
	smooth 2000, dat1473_numerical_entropy_avg_interp_scaled_fig4b

	
	//////////////////////////// occupation ///////////////////////////
	///// append data
	AppendToGraph /W=paper_figure_4b_symmetric dat1372_numerical_entropy_avg_interp_scaled_fig4b vs dat1372_cs_cleaned_avg_occ_interp; 
	AppendToGraph /W=paper_figure_4b_symmetric dat1473_numerical_entropy_avg_interp_scaled_fig4b vs dat1473_cs_cleaned_avg_occ_interp;   

	///// append fits
	AppendToGraph /W=paper_figure_4b_symmetric fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1372_cs_cleaned_avg_occ_interp;
	AppendToGraph /W=paper_figure_4b_symmetric fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b vs fit_dat1473_cs_cleaned_avg_occ_interp;

	Label /W=paper_figure_4b_symmetric bottom "Occupation (.arb)"
	//////////////////////////////////////////////////////////////////////
	
	
	// "0,0,0;	24158,34695,23901;	52685,33924,12336;	47802,0,2056;  14906,27499,34438;	14906,27499,34438 // black, green, yellow, red, blue
	string marker_size

	// modify data
	marker_size = "dat1372_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1372_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_symmetric mode(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0), mrkThick(dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1372_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 

	marker_size = "dat1473_numerical_entropy_avg_interp_scaled_fig4b" + "_marker_size"; create_marker_size(dat1473_numerical_entropy_avg_interp_scaled_fig4b, 16, min_marker=0.01, max_marker=2)
	ModifyGraph /W=paper_figure_4b_symmetric mode(dat1473_numerical_entropy_avg_interp_scaled_fig4b)=3, marker(dat1473_numerical_entropy_avg_interp_scaled_fig4b)=41, lsize(dat1473_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(dat1473_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056), mrkThick(dat1473_numerical_entropy_avg_interp_scaled_fig4b)=1, zmrkSize(dat1473_numerical_entropy_avg_interp_scaled_fig4b)={$marker_size,*,*,0.01,3} 


	// modify fits
	ModifyGraph /W=paper_figure_4b_symmetric mode(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1372_numerical_entropy_avg_interp_scaled_fig4b)=(0,0,0,49151)
	ModifyGraph /W=paper_figure_4b_symmetric mode(fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b)=0, lsize(fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b)=1, rgb(fit_dat1473_numerical_entropy_avg_interp_scaled_fig4b)=(47802,0,2056,49151)

	ModifyGraph /W=paper_figure_4b_symmetric notation(left)=1,manTick(left)={0,1,0,2},manMinor(left)={0,0}
	
	Label /W=paper_figure_4b_symmetric left "dN/dT (.arb)"
	
	beautify_figure("paper_figure_4b_symmetric")
	
	Legend/W=paper_figure_4b_symmetric /C/N=text0/J/F=0/A=LT "\\Zr080\\s(dat1473_numerical_entropy_avg_interp_scaled_fig4b) symmetric bias\r\\s(dat1372_numerical_entropy_avg_interp_scaled_fig4b) non-symmetric bias"

endmacro


	
macro paper_v3_figure_1a()
	Display; KillWindow /Z paper_figure_v3_1a; DoWindow/C/O paper_figure_v3_1a 
	
	AppendToGraph /W=paper_figure_v3_1a dat6080_dot_cleaned_avg_interp; 
	AppendToGraph /W=paper_figure_v3_1a /r dat6080_cs_cleaned_avg_occ_interp
	
	
	ModifyGraph /W=paper_figure_v3_1a rgb(dat6080_dot_cleaned_avg_interp)=(0,0,0)
	
	
	ModifyGraph /W=paper_figure_v3_1a muloffset={0.005,0}
	Label /W=paper_figure_v3_1a bottom "Sweepgate  (mV)"
	Label /W=paper_figure_v3_1a left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	Label /W=paper_figure_v3_1a right "Occupation (.arb)"
	
	
	ModifyGraph /W=paper_figure_v3_1a lsize=2
	SetAxis /W=paper_figure_v3_1a left 0,*
	SetAxis /W=paper_figure_v3_1a right 0,1
	
	Legend/W=paper_figure_v3_1a  /C/N=text0/J/A=LT/X=2.50/Y=3.23 "\\s(dat6080_dot_cleaned_avg_interp) Conductance\r\\s(dat6080_cs_cleaned_avg_occ_interp) Occupation"


	SetAxis /W=paper_figure_v3_1a bottom -5,5
	ModifyGraph /W=paper_figure_v3_1a mirror=0, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=8, tick=2, gFont="Calibri", gfSize=8, lowTrip(bottom)=0.0001, lowTrip(left)=0.01, width=1*200, height=1*200/1.6180339887
	ModifyGraph /W=paper_figure_v3_1a mirror(bottom)=1
endmacro


macro paper_v3_figure_1b()
// 1283 med strong
// 1282 med weak
	Display; KillWindow /Z paper_figure_v3_1b; DoWindow/C/O paper_figure_v3_1b 
	
	AppendToGraph /W=paper_figure_v3_1b dat1282_numerical_entropy_avg_interp; 
	AppendToGraph /W=paper_figure_v3_1b /r dat1282_cs_cleaned_avg_occ_interp
	
	
	ModifyGraph /W=paper_figure_v3_1b rgb(dat1282_numerical_entropy_avg_interp)=(0,0,0)
	
	
	ModifyGraph /W=paper_figure_v3_1b muloffset={0.005,0}
	Label /W=paper_figure_v3_1b bottom "Sweepgate  (mV)"
	Label /W=paper_figure_v3_1b left "dN/dt"
	Label /W=paper_figure_v3_1b right "Occupation (.arb)"
	
	
	ModifyGraph /W=paper_figure_v3_1b lsize=2
//	SetAxis /W=paper_figure_v3_1b left 0,*
	SetAxis /W=paper_figure_v3_1b right 0,1

	Legend/W=paper_figure_v3_1b  /C/N=text0/J/A=LT/X=2.50/Y=3.23 "\\s(dat1282_numerical_entropy_avg_interp) dN/dT\r\\s(dat1282_cs_cleaned_avg_occ_interp) Occupation"


	SetAxis /W=paper_figure_v3_1b bottom -5,5
	ModifyGraph /W=paper_figure_v3_1b mirror=0, nticks=3, axThick=0.5, btLen=3, stLen=2, fsize=8, tick=2, gFont="Calibri", gfSize=8, lowTrip(bottom)=0.0001, lowTrip(left)=0.01, width=1*200, height=1*200/1.6180339887
	ModifyGraph /W=paper_figure_v3_1b mirror(bottom)=1
	ModifyGraph /W=paper_figure_v3_1b muloffset(dat1282_numerical_entropy_avg_interp)={0.005,100}
endmacro


function figure_2_conductance()
//	variable gamma_value =  2.5
//	variable leverarm_value = 1e-3
	variable gamma_value =  3.8
	variable leverarm_value =  0.00587914


///////////////////////////////////////////////////////////////////////////////
////////////// SPRING CONDUCTANCE 2024 AND TRANSITION DATA //////////////////// 
///////////////////////////////////////////////////////////////////////////////
// (more weakly coupled datasets)
//	string datnums = "681;699;693;687"; string gamma_type = "mid" // low gamma - 640 2uV
//	string datnums = "682;700;694;688"; string gamma_type = "mid" // mid gamma - 640 2uV
//	string datnums = "683;701;695;689"; string gamma_type = "mid" // high gamma - 640 2uV

//	string datnums = "737;701;695;689"; string gamma_type = "mid" // high gamma - 640 1uV
//	string datnums = "738;701;695;689"; string gamma_type = "mid" // high gamma - 640 2uV
//	string datnums = "739;701;695;689"; string gamma_type = "mid" // high gamma - 640 5uV
	
//	string datnums = "684;702;696;690"; string gamma_type = "mid" // low gamma - 840 2uV
//	string datnums = "685;703;697;691"; string gamma_type = "mid" // mid gamma - 840 2uV
//	string datnums = "686;704;698;692"; string gamma_type = "mid" // high gamma - 840 2uV
//
//	string e_temps = "22;90;275;400"
//	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
//	


	///// P = -1040 Symmetric (more strongly coupled)
//	string datnums = "810;826;822;818;814"; string gamma_type = "mid" // mid gamma - 1040 1uV
//	string datnums = "811;827;823;819;815"; string gamma_type = "mid" // mid-strong gamma - 1040 1uV
//	string datnums = "812;828;824;820;816"; string gamma_type = "strong" // strong gamma - 1040 1uV
//	string datnums = "813;829;825;821;817"; string gamma_type = "strong" // strong gamma - 1040 1uV
////
//	string e_temps = "22.5;90;175;275;400"
//	string colours = "0,0,65535;29524,1,58982;65535,65535,0;64981,37624,14500;65535,0,0"
//	
//	string datnums = "810;826;814"; string gamma_type = "mid" // mid gamma - 1040 1uV
//	string datnums = "811;827;815"; string gamma_type = "mid" // mid-strong gamma - 1040 1uV
//	string datnums = "812;828;816"; string gamma_type = "strong" // strong gamma - 1040 1uV
//	string datnums = "813;829;817"; string gamma_type = "strong" // strong gamma - 1040 1uV
//	string e_temps = "22.5;90;400"
//	string colours = "0,0,65535;29524,1,58982;65535,0,0"


//	///// Asymmetric attempt 1
////	string datnums = "1171;1195;1189;1183;1177"; string gamma_type = "mid" // mid gamma - 1040 1uV
////	string datnums = "1173;1197;1191;1185;1179"; string gamma_type = "mid" // mid gamma - 1040 1uV
//	string datnums = "1175;1199;1193;1187;1181"; string gamma_type = "mid" // mid gamma - 1040 1uV
////
//	string e_temps = "22.5;50;90;275;400"
//	string colours = "0,0,65535;29524,1,58982;65535,65535,0;64981,37624,14500;65535,0,0"


//	///// Asymmetric attempt 2 (all temperatures)
//	string datnums = "1327;1375;1367;1359;1351;1343;1335"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1328;1376;1368;1360;1352;1344;1336"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1329;1377;1369;1361;1353;1345;1337"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1330;1378;1370;1362;1354;1346;1338"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1331;1379;1371;1363;1355;1347;1339"; string gamma_type = "mid" // 1.6nA

//	string e_temps = "22.5;30;50;90;175;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"


//	///// Asymmetric attempt 2 (base and 90mK up)
//	string datnums = "1327;1359;1351;1343;1335"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1328;1360;1352;1344;1336"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1329;1361;1353;1345;1337"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1330;1362;1354;1346;1338"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1331;1363;1355;1347;1339"; string gamma_type = "mid" // 1.6nA
//
//	string e_temps = "22.5;90;175;275;400"
//	string colours = "0,0,6553565535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"
	
	
//	///// Asymmetric attempt 2 v2 (base and 90mK up)
	///// set point 1 /////
//	string datnums = "1412;1536;1496;1454"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1413;1537;1497;1455"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1414;1538;1498;1456"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1415;1539;1499;1457"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1416;1540;1500;1458"; string gamma_type = "mid" // 1.6nA
	
	///// set point 2 /////
//	string datnums = "1418;1542;1502;1460"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1419;1543;1503;1461"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1420;1544;1504;1462"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1421;1545;1505;1463"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1422;1546;1506;1464"; string gamma_type = "mid" // 1.6nA

	///// set point 3 /////
//	string datnums = "1424;1548;1508;1466"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1425;1549;1509;1467"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1426;1550;1510;1468"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1427;1551;1511;1469"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1428;1552;1512;1470"; string gamma_type = "mid" // 1.6nA
	
	///// set point 4 /////
//	string datnums = "1430;1554;1514;1472"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1431;1555;1515;1473"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1432;1556;1516;1474"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1433;1557;1517;1475"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1434;1558;1518;1476"; string gamma_type = "mid" // 1.6nA
	
	///// set point 5 /////
//	string datnums = "1436;1560;1520;1478"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1437;1561;1521;1479"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1438;1562;1522;1480"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1439;1563;1523;1481"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1440;1564;1524;1482"; string gamma_type = "mid" // 1.6nA


	///// set point 6 /////
//	string datnums = "1442;1566;1526;1484"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1443;1567;1527;1485"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1444;1568;1528;1486"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1445;1569;1529;1487"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1446;1570;1530;1488"; string gamma_type = "mid" // 1.6nA
	
	
	///// set point 7 /////
//	string datnums = "1448;1572;1532;1490"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1449;1573;1533;1491"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1450;1574;1534;1492"; string gamma_type = "mid" // 1.0nA dont have 275 mK data
//	string datnums = "1451;1575;1535;1493"; string gamma_type = "mid" // 1.3nA dont have 275 mK data
//	string datnums = "1452;1576;1536;1494"; string gamma_type = "mid" // 1.6nA dont have 275 mK data
	
	///// set point 1 /////
//	string datnums = "1412;1536;1496;1454"; string gamma_type = "mid" // 0.4nA

	///// set point 3 /////
//	string datnums = "1424;1548;1508;1466"; string gamma_type = "mid" // 0.4nA

	///// set point 5 /////
//	string datnums = "1436;1560;1520;1478"; string gamma_type = "mid" // 0.4nA
	
	///// set point 7 /////
	string datnums = "1448;1572;1532;1490"; string gamma_type = "mid" // 0.4nA


	string e_temps = "20;90;275;400"
	string colours = "0,0,65535;65535,65535,0;65535,21845,0;65535,0,0"

	///// Setpoints (all temperatures)
//	string datnums = "1239;1275;1269;1263;1257;1251;1245"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1240;1276;1270;1264;1258;1252;1246"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1241;1277;1271;1265;1259;1253;1247"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1242;1278;1272;1266;1260;1254;1248"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1243;1279;1273;1267;1261;1255;1249"; string gamma_type = "mid" // 1.6nA

//	string datnums = "1333;1381;1373;1365;1357;1349;1341"; string gamma_type = "mid" // 0.4nA REDO
//
//	string e_temps = "22.5;30;50;90;175;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"

	///// Setpoint  (base and 90mK up)
//	string datnums = "1239;1263;1257;1251;1245"; string gamma_type = "mid" // 0.4nA
//	string datnums = "1240;1264;1258;1252;1246"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1241;1265;1259;1253;1247"; string gamma_type = "mid" // 1.0nA
//	string datnums = "1242;1266;1260;1254;1248"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1243;1267;1261;1255;1249"; string gamma_type = "mid" // 1.6nA

//	string datnums = "1333;1365;1357;1349;1341"; string gamma_type = "mid" // 0.4nA REDO
//

//	string e_temps = "20;90;175;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"

//	///// Setpoint  (base and 90mK up)
//	string datnums = "1239;1263;1257;1251;1245"; string gamma_type = "mid" // 0.4nA
////////	string datnums = "1240;1264;1258;1252;1246"; string gamma_type = "mid" // 0.7nA
//	string datnums = "1241;1265;1259;1253;1247"; string gamma_type = "mid" // 1.0nA
//////////	string datnums = "1242;1266;1260;1254;1248"; string gamma_type = "mid" // 1.3nA
//	string datnums = "1243;1267;1261;1255;1249"; string gamma_type = "mid" // 1.6nA
//
//	string e_temps = "20;90;187;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"



//	
	
	
// 1st and 2nd plateau CS setpoint
//Setpoint 1
//	string datnums = "1612;1642;1632;1622"; string gamma_type = "mid" // 3.0nA
//	string datnums = "1613;1643;1633;1623"; string gamma_type = "mid" // 3.1nA
//	string datnums = "1614;1644;1634;1624"; string gamma_type = "mid" // 3.3nA
//	string datnums = "1615;1645;1635;1625"; string gamma_type = "mid" // 3.5nA

//Setpoint 7
//	string datnums = "1617;1647;1637;1627"; string gamma_type = "mid" // 3.0nA
//	string datnums = "1618;1648;1638;1628"; string gamma_type = "mid" // 3.1nA
//	string datnums = "1619;1649;1639;1629"; string gamma_type = "mid" // 3.3nA
//	string datnums = "1620;1650;1640;1630"; string gamma_type = "mid" // 3.5nA

//	string e_temps = "22.5;90;275;400"
//	string colours = "0,0,65535;65535,65535,0;65535,21845,0;65535,0,0"

///////////////////////////////////////////////////////////////////////////////
////////////// SUMMER CONDUCTANCE 2024 AND TRANSITION DATA //////////////////// 
///////////////////////////////////////////////////////////////////////////////
///ALL TEMPS
//Setpoint 1
//	string datnums = "2901;2961;2946;2931;2916"; string gamma_type = "mid" // 0.4nA REDO
//	string datnums = "2902;2962;2947;2932;2917"; string gamma_type = "mid" // 0.7nA REDO
//	string datnums = "2903;2963;2948;2933;2918"; string gamma_type = "mid" // 1.0nA REDO
//
////Setpoint 2
//	string datnums = "2906;2966;2951;2936;2921"; string gamma_type = "mid" // 0.4nA REDO
//	string datnums = "2907;2967;2952;2937;2922"; string gamma_type = "mid" // 0.7nA REDO
//	string datnums = "2908;2968;2953;2938;2923"; string gamma_type = "mid" // 1.0nA REDO
//
////Setpoint 3
//	string datnums = "2911;2971;2956;2941;2926"; string gamma_type = "mid" // 0.4nA REDO
//	string datnums = "2912;2972;2957;2942;2927"; string gamma_type = "mid" // 0.7nA REDO
//	string datnums = "2913;2973;2958;2943;2928"; string gamma_type = "mid" // 1.0nA REDO


//	string e_temps = "22.5;50;90;275;400"
//	string colours = "0,0,65535;16385,49025,65535;65535,65535,0;65535,21845,0;65535,0,0"
	
	
// 2T
///ALL TEMPS
//Setpoint 1
//	string datnums = "2997;3047;3037;3027;3017;3007"; string gamma_type = "mid" // 0.4nA REDO
//	string datnums = "2998;3048;3038;3028;3018;3008"; string gamma_type = "mid" // 0.7nA REDO
//	string datnums = "2999;3049;3039;3029;3019;3009"; string gamma_type = "mid" // 1.0nA REDO
//
////Setpoint 2
//	string datnums = "3002;3052;3042;3032;3022;3012"; string gamma_type = "mid" // 0.4nA REDO
//	string datnums = "3003;3053;3043;3033;3023;3013"; string gamma_type = "mid" // 0.7nA REDO
//	string datnums = "3004;3054;3044;3034;3024;3014"; string gamma_type = "mid" // 1.0nA REDO
//



//	string e_temps = "22.5;30;50;90;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,21845,0;65535,0,0"
	
//	string datnums = "3089;3221;3199;3177;3155;3133;3111"; string gamma_type = "mid" // 1.0nA REDO
//	string e_temps = "22.5;30;50;90;175;275;400"
//	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,21845,0;65535,0,0"

	

///////////////////////////////////////////////////////////////////////////////
//////////// SPRING CONDUCTANCE 2023 AND TRANSITION DATA ////////////////////// 
///////////////////////////////////////////////////////////////////////////////
//	string datnums = "6079;6088;6085;6082"; string gamma_type = "high"// high gamma
//	string datnums = "6386;6088;6085;6082"; string gamma_type = "high"// high gamma (just before entropy scan 22.5 fits well 15mK fits best)
//	string datnums = "6080;6089;6086;6083"; string gamma_type = "mid" // mid gamma
//	string datnums = "6081;6090;6087;6084"; string gamma_type = "low" // low gamma

//	string datnums = "6100;6097;6094;6091"; string gamma_type = "high" // high gamma :: high field

//	string datnums = "6225;6234;6231;6228"; string gamma_type = "high" // high gamma :: 2-3 transition
//	string datnums = "6226;6235;6232;6229"; string gamma_type = "high" // high gamma :: 2-3 transition

//	string e_temps = "12;100;300;500"
//	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
// 0.765173 7.2439 19.3344 :: SPRING 2023



///////////////////////////////////////////////////////////////////////////////
///////////////// AUTUMN CONDUCTANCE AND TRANSITION DATA //////////////////////
///////////////////////////////////////////////////////////////////////////////
//	string datnums = "696;692;688"; string gamma_type = "low"; //string e_temps = "23;275.61;494" // low gamma
//	string datnums = "697;693;689"; string gamma_type = "mid"; //string e_temps = "23;274.504;501.439"// mid-low gamma
//	string datnums = "698;694;690"; string gamma_type = "mid"; //string e_temps = "23;275.373;498.635"// mid-high gamma
//	string datnums = "699;695;691"; string gamma_type = "high"; //string e_temps = "23;274.869;496.522"// high gamma


//	string e_temps = "12;275;500"
//	string colours = "0,0,65535;64981,37624,14500;65535,0,0"
// 3.30077  7.09738  19.7605  27.6116 :: AUTUMN 2023


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
	variable cond_chisq, occ_chisq, dndt_chisq
	[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(e_temps, datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_conductance=1, fit_entropy=0, fit_entropy_dats="", gamma_value=gamma_value, leverarm_value=leverarm_value)	
	
	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
	Display; KillWindow /Z figure_cond_vs_occ; DoWindow/C/O figure_cond_vs_occ 
	
	string cond_avg, cond_avg_fit, coef_cond
	string trans_avg, trans_avg_fit, coef_trans
	string occ_avg, occ_avg_fit
	
	string occupation_coef_name
	
	string legend_text = ""
	variable datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, datnums))
		e_temp = stringfromlist(i, e_temps)
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		coef_cond = "coef_" + cond_avg
		if (global_fit_conductance == 1)
			cond_avg_fit = "GFit_" + cond_avg
		else
			cond_avg_fit = "fit_" + cond_avg
		endif
		
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		coef_trans = "coef_" + trans_avg
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
		ModifyGraph /W=figure_ca mode($cond_avg_fit)=0, lsize($cond_avg_fit)=2, rgb($cond_avg_fit)=(0,0,0)
		
		
		//////////////////////////////////////////
		///// ADDING OCCUPATION VS SWEEPGATE /////
		//////////////////////////////////////////
		///// Appending traces to panel ca /////
		AppendToGraph /W=figure_ca /L=l2/B=b2 $trans_avg; AppendToGraph /W=figure_ca /L=l2/B=b2 $trans_avg_fit;
		ModifyGraph /W=figure_ca mode($trans_avg)=2, lsize($trans_avg)=2, rgb($trans_avg)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($trans_avg_fit)=0, lsize($trans_avg_fit)=2, rgb($trans_avg_fit)=(0,0,0)
		
		///// Appending traces to panel cb /////
		AppendToGraph /W=figure_ca /L=l4/B=b4 $occ_avg; AppendToGraph /W=figure_ca /L=l4/B=b4 $occ_avg_fit;
		ModifyGraph /W=figure_ca mode($occ_avg)=2, lsize($occ_avg)=1, rgb($occ_avg)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($occ_avg_fit)=0, lsize($occ_avg_fit)=2, rgb($occ_avg_fit)=(0,0,0)		
		
		
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
		[minx, maxx] = find_overlap_mask($(trans_avg+"_mask"), $(cond_avg+"_mask"))	
			
		// interpolating occupation to have higher density of points
		string cond_vs_occ_data_wave_name_x = occ_avg + "_interp"
		
		duplicate /o $occ_avg $cond_vs_occ_data_wave_name_x
//		interpolate_wave(cond_vs_occ_data_wave_name_x, $occ_avg, numpts_to_interp=10000)

		delete_points_from_x($cond_vs_occ_data_wave_name_x, minx, maxx)

		// interpolating conduction to have data at same x points as occuptaion data
		string cond_vs_occ_data_wave_name_y = cond_avg + "_interp"
		interpolate_wave(cond_vs_occ_data_wave_name_y, $cond_avg, xwave_to_duplicate=$cond_vs_occ_data_wave_name_x)
		
//		// deleting points outside of mask
//		delete_points_from_x($cond_vs_occ_data_wave_name_x, minx, maxx)
//		delete_points_from_x($cond_vs_occ_data_wave_name_y, minx, maxx)
//		
		
		///////////////////////////////////
		///// interpolating fit waves /////
		///////////////////////////////////		
//		///// re-finding fits from NRG /////
		string cond_vs_occ_fit_wave_name_x = occ_avg_fit + "_interp"
		string cond_vs_occ_fit_wave_name_y = cond_avg_fit + "_interp"
		
		// pulling x-wave from NRG
		wave g_nrg
		create_x_wave(g_nrg)
		wave x_wave
		
		// pulling NRG occ
		duplicate /o x_wave $cond_vs_occ_fit_wave_name_x
		fitfunc_rawnrgocc($coef_trans, $cond_vs_occ_fit_wave_name_x)
		
		// pulling NRG cond
		duplicate /o x_wave $cond_vs_occ_fit_wave_name_y
		fitfunc_rawnrgcond($coef_cond, $cond_vs_occ_fit_wave_name_y)
		
		////// plotting
		AppendToGraph /W=figure_ca /L=left/B=bottom $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x; AppendToGraph /W=figure_ca /L=left/B=bottom $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
		ModifyGraph /W=figure_ca mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
		ModifyGraph /W=figure_ca mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(0,0,0)
		
		
		////// plotting
		AppendToGraph /W=figure_cond_vs_occ /L=left/B=bottom $cond_vs_occ_data_wave_name_y vs $cond_vs_occ_data_wave_name_x; AppendToGraph /W=figure_cond_vs_occ /L=left/B=bottom $cond_vs_occ_fit_wave_name_y vs $cond_vs_occ_fit_wave_name_x;
		ModifyGraph /W=figure_cond_vs_occ mode($cond_vs_occ_data_wave_name_y)=2, lsize($cond_vs_occ_data_wave_name_y)=2, rgb($cond_vs_occ_data_wave_name_y)=(red,green,blue)
		ModifyGraph /W=figure_cond_vs_occ mode($cond_vs_occ_fit_wave_name_y)=0, lsize($cond_vs_occ_fit_wave_name_y)=2, rgb($cond_vs_occ_fit_wave_name_y)=(0,0,0)
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
	ModifyGraph /W = figure_ca freePos(b2)={0,l2}
	ModifyGraph /W = figure_ca freePos(b3)={0,l3}
		
	///// remove label from b2 /////
//	ModifyGraph /W = figure_ca noLabel(b2)=2
	
	ModifyGraph /W = figure_ca freePos(l2)=0
	ModifyGraph /W = figure_ca freePos(l3)=0
	
	ModifyGraph /W = figure_ca noLabel(b4)=2
	ModifyGraph /W = figure_ca noLabel(l4)=2
	
	///// setting  axis labels /////
	Label /W=figure_ca l3 "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	Label /W=figure_ca l2 "Current (nA)"
	Label /W=figure_ca left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	
	Label /W=figure_ca bottom "Occupation (.arb)"
	Label /W=figure_ca b2 "Sweep Gate (mV)"
	
	
	Label /W=figure_cond_vs_occ left "Conductance (\\$WMTEX$ 2e^2  \\$/WMTEX$/ h)"
	Label /W=figure_cond_vs_occ bottom "Occupation (.arb)"
	SetAxis /W=figure_cond_vs_occ left 0,*
	SetAxis /W=figure_cond_vs_occ bottom 0,1
	
	///// off-setting labels from the axis /////
	ModifyGraph /W=figure_ca lblPos(l2)=150
	ModifyGraph /W=figure_ca lblPos(l3)=150
	ModifyGraph /W=figure_ca lblPos(left)=150
	ModifyGraph /W=figure_ca lblPos(bottom)=80
	ModifyGraph /W=figure_ca lblPos(b2)=20
	
	
	///// adding legend /////
	Legend/W=figure_ca/C/N=legend_figc/J/A=LT legend_text

	beautify_figure("figure_ca")
	
	TileWindows/O=1/C/P
end




function fit_leverarm_temp_depend()
	variable gamma_value =  2.5
	variable leverarm_value = 1e-3
	int show_weak_fits_only = 0

	
	string gamma_type = "mid"
	
	string mega_datnums = "3089;3221;3199;3177;3155;3133;3111,3090;3222;3200;3178;3156;3134;3112,3091;3223;3201;3179;3157;3135;3113,3092;3224;3202;3180;3158;3136;3114,3093;3225;3203;3181;3159;3137;3115,3094;3226;3204;3182;3160;3138;3116,3095;3227;3205;3183;3161;3139;3117,3096;3228;3206;3184;3162;3140;3118,3097;3229;3207;3185;3163;3141;3119,3098;3230;3208;3186;3164;3142;3120,3099;3231;3209;3187;3165;3143;3121,3100;3232;3210;3188;3166;3144;3122,3101;3233;3211;3189;3167;3145;3123,3102;3234;3212;3190;3168;3146;3124,3103;3235;3213;3191;3169;3147;3125,3104;3236;3214;3192;3170;3148;3126,3105;3237;3215;3193;3171;3149;3127,3106;3238;3216;3194;3172;3150;3128,3107;3239;3217;3195;3173;3151;3129,3108;3240;3218;3196;3174;3152;3130,3109;3241;3219;3197;3175;3153;3131,3110;3242;3220;3198;3176;3154;3132"
//	string mega_datnums = "3089;3221;3199;3177;3155;3133;3111,3090;3222;3200;3178;3156;3134;3112"
	
	
	make/o N_Var = {-591.433,-572.346,-555.646,-530.197,-496.795,-473.732,-450.669,-428.402,-409.315,-387.047,-371.142,-353.646,-332.173,-313.882,-294.795,-278.89,-262.984,-243.898,-230.378,-220.039,-205.724,-193.795}


	string e_temps = "22.5;30;50;90;175;275;400"
	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"
	

	string colour, e_temp
	variable red, green, blue
	
	int global_fit_conductance = 0
	
	
	
	variable num_dat_groups = ItemsInList(mega_datnums, ","); print "Num dat groups = ",  num_dat_groups
	variable num_dat_per_group = ItemsInList(stringfromlist(0, mega_datnums, ","), ";"); ; print "Num dat per group = ",  num_dat_per_group
	
	variable num_dats = num_dat_groups*num_dat_per_group; print "Num dats in toal = ", num_dats
	
	make /o /n=(40, num_dats) leverarm_fit_info
	wave leverarm_fit_info
	variable mc_temperature
	
	Make/O/N=(num_dats,3) zW=0

	variable cond_chisq, occ_chisq, dndt_chisq
	
//	Display; KillWindow /Z figure_ca; DoWindow/C/O figure_ca 
//	Display; KillWindow /Z figure_cond_vs_occ; DoWindow/C/O figure_cond_vs_occ 
	
	string cond_avg, cond_avg_fit, coef_cond
	string trans_avg, trans_avg_fit, coef_trans
	string occ_avg, occ_avg_fit
	string occupation_coef_name
	string legend_text = ""
	
	variable datnum
	string datnums
	int j, i
	for (j=0;j<num_dat_groups;j+=1)
		datnums = stringfromlist(j, mega_datnums, ",")
	
		for (i=0;i<num_dat_per_group;i+=1)
			datnum = str2num(stringfromlist(i, datnums))
			e_temp = stringfromlist(i, e_temps)
			cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
			coef_cond = "coef_" + cond_avg
			if (global_fit_conductance == 1)
				cond_avg_fit = "GFit_" + cond_avg
			else
				cond_avg_fit = "fit_" + cond_avg
			endif
			
			trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
			coef_trans = "coef_" + trans_avg
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
			
//			zW[i+j*num_dat_per_group][0] = round(red/65535*255)
//			zW[i+j*num_dat_per_group][2] = round(green/65535*255)
//			zW[i+j*num_dat_per_group][1] = round(blue/65535*255)
			
			zW[i+j*num_dat_per_group][0] = red
			zW[i+j*num_dat_per_group][2] = green
			zW[i+j*num_dat_per_group][1] = blue
			
			
			get_initial_params($trans_avg)
			fit_transition($trans_avg, 0, (dimsize($trans_avg, 0) - 1)); // print W_coef
			wave W_coef
			leverarm_fit_info[3,8][i+j*num_dat_per_group] = W_coef[p-3]
			
			if (show_weak_fits_only == 1)
				display $trans_avg
				appendtograph $("fit_" + trans_avg)
				ModifyGraph rgb($("fit_" + trans_avg))=(0,0,0)
			endif
			
			if ((show_weak_fits_only == 0) && (i == 0))
				[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(e_temps, datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_conductance=0, fit_entropy=0, fit_entropy_dats="", gamma_value=gamma_value, leverarm_value=leverarm_value)
				closeallgraphs()
				wave globalfitcoefficients
			endif
			
			
			leverarm_fit_info[0][i+j*num_dat_per_group] = datnum
			mc_temperature = fd_gettemperature(datnum, which_plate="MC K")
			leverarm_fit_info[1][i+j*num_dat_per_group] = mc_temperature
			leverarm_fit_info[2][i+j*num_dat_per_group] = N_Var[j]
			leverarm_fit_info[9,39][i + j*num_dat_per_group] = globalfitcoefficients[p-9]
			
		endfor

	
	
	endfor


	// display weak theta 
	display leverarm_fit_info[5][] vs leverarm_fit_info[2][]
	ModifyGraph rgb=(0,0,0)
	ModifyGraph mode=3
	Label bottom "N (mV)"
	Label left "Weak Theta"
	ModifyGraph zColor(leverarm_fit_info)={zw,*,*,directRGB}
	
	// display global GT
	display leverarm_fit_info[9][] vs leverarm_fit_info[2][]
	ModifyGraph rgb=(0,0,0)
	ModifyGraph mode=3
	Label bottom "N (mV)"
	Label left "ln(GT)"

	
	// display global GT
	display leverarm_fit_info[10][] vs leverarm_fit_info[2][]
	ModifyGraph rgb=(0,0,0)
	ModifyGraph mode=3
	Label bottom "N (mV)"
	Label left "Global Leverarm"
	
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



function etemp_test_single()
//	wave wave_to_fit = dat1372_numerical_entropy_avg_interp
//	wave wave_to_fit_mask = dat1284_cs_cleaned_avg_mask
//	wave coef_wave = coef_dat1288_cs_cleaned_avg
	wave wave_to_fit = dat684_dot_cleaned_avg
	wave wave_to_fit_mask = dat684_dot_cleaned_avg_mask
	wave coef_wave = coef_dat684_dot_cleaned_avg
	
	// lngt and leverarm ranges
	variable num_lngt = 50, min_lngt = 1e-4, max_lngt = 1
	variable num_leverarm = 50, min_leverarm = 1e-2, max_leverarm = 1
	
	// duplicating wave to fit
	duplicate /o wave_to_fit wave_to_fit_etemp
	wave wave_to_fit_etemp
	
	// setting coef
//	duplicate /o coef_dat1288_cs_cleaned_avg etemp_test_single_coef
	make/o /n=7 etemp_test_single_coef = 0
	wave etemp_test_single_coef
	
	// for entropy wave
	etemp_test_single_coef[0,6] = coef_wave[p]; 
	//etemp_test_single_coef[4]=wavemax(wave_to_fit);  etemp_test_single_coef[5]=0; etemp_test_single_coef[6]=0; //etemp_test_single_coef[7]=1;

	
	variable lngt, leverarm, chisq
	
	make /o/n=(num_lngt,num_leverarm) chisq_wave
	wave chisq_wave
	
	int i,j
	for (i=0; i < num_lngt; i++)
		for (j=0; j < num_leverarm; j++)
		
			lngt = min_lngt + (max_lngt - min_lngt)*i/num_lngt
			leverarm = min_leverarm + (max_leverarm - min_leverarm)*j/num_leverarm
			
			etemp_test_single_coef[0] = lngt
			etemp_test_single_coef[1] = leverarm
			// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: const offset
	// coef[5]: linear
	// coef[6]: quadratic
	// coef[7]: amplitude
//			FuncFit/Q/H="11110110" fitfunc_nrgentropyAAO etemp_test_single_coef wave_to_fit_etemp /D ///M=wave_to_fit_mask /D

// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: peak height
	// coef[5]: const offset
	// coef[6]: linear
			etemp_test_single_coef[2] = coef_wave[2]
			etemp_test_single_coef[4] = coef_wave[4]
			
			FuncFit/Q/H="1101011" fitfunc_nrgcondAAO etemp_test_single_coef wave_to_fit_etemp /D ///M=wave_to_fit_mask /D
			chisq =  V_chisq
			
			chisq_wave[i][j] = chisq
		endfor
	endfor
	setscale /I x, min_lngt, max_lngt, chisq_wave
	setscale /I y, min_leverarm, max_leverarm, chisq_wave
	
	display; appendimage chisq_wave
	Label left "Leverarm";DelayUpdate
	Label bottom "ln(G/T)"
	
	ModifyImage chisq_wave ctab= {*,*,BlackBody,0}
	
	ColorScale/C/N=text3/A=RT image=chisq_wave
	ColorScale/C/N=text3 "chi-squared"
	
	create_x_wave(chisq_wave)
	wave x_wave

	create_y_wave(chisq_wave)
	wave y_wave

	ImageStats /q chisq_wave
	make /o/n=1 min_val_wave_x = {x_wave[V_minRowLoc]}
	make /o/n=1 min_val_wave_y = {y_wave[V_minColLoc]}

	appendtograph /l=left/b=bottom min_val_wave_y vs min_val_wave_x
	
	ModifyGraph mode=3,lsize=3,rgb=(0,0,0)
	ModifyGraph msize=15
	ModifyGraph marker=1
	ModifyGraph mrkThick=2
	
	ModifyGraph mirror=1, nticks=3, axThick=0.5, fsize=14, tick=2, gFont="Calibri", gfSize=14, lowTrip(top)=0.0001, lowTrip(left)=0.01//, width=1*400, height=1*400/1.6180339887

	
	
end




function etemp_test_global()	
	variable cold_gt = 0, hot_gt = 0
	variable cold_leverarm = 0, hot_leverarm = 0
	variable gamma_value, leverarm_value
	int global_fit_conductance, fit_conductance = 0, fit_entropy = 0
	string entropy_datnums = "", gamma_over_temp_type
	
		///// SPRING CONDUCTANCE ///// 
////	string datnums = "6079;6088;6085;6082"; cold_gt = 3.5; hot_gt = 3.5; cold_leverarm = 0.02; hot_leverarm = 0.02;  gamma_over_temp_type = "high"// high gamma
////	string datnums = "6386;6088;6085;6082"; cold_gt = 0; hot_gt = 0; cold_leverarm = 0; hot_leverarm = 0;  gamma_over_temp_type = "high"// high gamma 
////	string datnums = "6080;6089;6086;6083"; cold_gt = 2.62239; hot_gt = 0.0880556; cold_leverarm = 0.0165262; hot_leverarm = 0.023509;  gamma_over_temp_type = "mid" // mid gamma
//	string datnums = "6081;6090;6087;6084"; cold_gt = 1.3; hot_gt = -2.66677; cold_leverarm = 0.2; hot_leverarm = 0.993224;  gamma_over_temp_type = "low" // low gamma
//	string base_temps = ";100;300;500"
//	fit_conductance = 1

//
////	///// AUTUMN CONDUCTANCE AND TRANSITION DATA ///// 

//	string datnums = "696;692;688"; cold_gt = 1.0; hot_gt = 1.0; cold_leverarm = 0.02; hot_leverarm = 0.02;  gamma_over_temp_type = "low"; // low gamma
////	string datnums = "697;693;689"; cold_gt = 2.0; hot_gt = 2.0; cold_leverarm = 0.2; hot_leverarm = 0.2;  gamma_over_temp_type = "mid"; // mid-low gamma
////	string datnums = "698;694;690"; cold_gt = 3.5; hot_gt = 3.5; cold_leverarm = 1e-2; hot_leverarm = 1e-2;  gamma_over_temp_type = "mid"; // mid-high gamma
////	string datnums = "699;695;691"; cold_gt = 3.9; hot_gt = 3.9; cold_leverarm = 1e-2; hot_leverarm = 1e-2;  gamma_over_temp_type = "high"; // high gamma
//	string base_temps = ";275;500"
//	fit_conductance = 1

	string datnums = "1333;1365;1357;1349;1341"; cold_gt = 3.9; hot_gt = 3.9; cold_leverarm = 0.007; hot_leverarm = 0.007;  gamma_over_temp_type = "mid" // 0.4nA REDO
	string base_temps = ";90;175;275;400"
	fit_conductance = 1

	///// SPRING ENTROPY ///// 
////	string datnums = "6079;6088;6085;6082";  gamma_over_temp_type = "high"// high gamma
////	string datnums = "6080;6089;6086;6083";  gamma_over_temp_type = "mid" // mid gamma
////	string datnums = "6081;6090;6087;6084";  gamma_over_temp_type = "low" // low gamma
//
//	string entropy_datnums = "6388"; string datnums = "6079;6088;6085;6082"; gamma_over_temp_type = "high"; info_mask_waves("6388", base_wave_name="_cs_cleaned_avg")
////	string entropy_datnums = "6385"; string datnums = "6079;6088;6085;6082"; gamma_over_temp_type = "high"; info_mask_waves("6385", base_wave_name="_cs_cleaned_avg")
//	
//	string datnums = "6100;6097;6094;6091";  gamma_over_temp_type = "high" // high gamma :: high field
//	string datnums = "6225;6234;6231;6228";  gamma_over_temp_type = "high" // high gamma :: 2-3 transition
//	string datnums = "6226;6235;6232;6229";  gamma_over_temp_type = "high" // high gamma :: 2-3 transition
//  string base_temps = ";100;300;500"
//	fit_entropy = 1
	
//	///// AUTUMN ENTROPY /////
//	entropy_datnums = "1281"; string datnums = "1285;1297;1293;1289"; gamma_over_temp_type = "low"; info_mask_waves("1281", base_wave_name="_cs_cleaned_avg")
//    entropy_datnums = "1282"; string datnums = "1286;1298;1294;1290"; gamma_over_temp_type = "low"; info_mask_waves("1282", base_wave_name="_cs_cleaned_avg")
//	entropy_datnums = "1283"; string datnums = "1287;1299;1295;1291"; gamma_over_temp_type = "high"; info_mask_waves("1283", base_wave_name="_cs_cleaned_avg")
//	entropy_datnums = "1284"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1284", base_wave_name="_cs_cleaned_avg") // 100uV bias

//	string entropy_datnums = "1372"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1372", base_wave_name="_cs_cleaned_avg") // 50uV bias
//	string entropy_datnums = "1373"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1373", base_wave_name="_cs_cleaned_avg") // 250uV bias
//	string entropy_datnums = "1374"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1374", base_wave_name="_cs_cleaned_avg") // 500uV bias
//	string entropy_datnums = "1439"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1439", base_wave_name="_cs_cleaned_avg") // 1000uV bias
	
//	string entropy_datnums = "1473"; string datnums = "1288;1300;1296;1292"; gamma_over_temp_type = "high"; info_mask_waves("1473", base_wave_name="_cs_cleaned_avg") // 50uV bias :: symmetric
//	string base_temps = ";90;275;400"
//	fit_entropy = 1
	
	global_fit_conductance = 1
	
	
	closeallGraphs()
	
	
	string global_temps
	
	variable num_temperatures = 30

	int min_temp = 8
	int max_temp = 90
	
	make /o/n=(num_temperatures) e_temps
	wave e_temps
	
	e_temps = x
	e_temps /= num_temperatures
	e_temps *= (max_temp - min_temp)
	e_temps += min_temp
	
	make /o/n=(num_temperatures) cond_chisq_wave; wave cond_chisq_wave
	make /o/n=(num_temperatures) occ_chisq_wave; wave occ_chisq_wave	
	make /o/n=(num_temperatures) dndt_chisq_wave; wave dndt_chisq_wave
	
	make /o/n=(num_temperatures) calc_gt; wave calc_gt
	make /o/n=(num_temperatures) calc_leverarm; wave calc_leverarm	
	
	variable cond_chisq, occ_chisq, dndt_chisq
	
	variable i
	for (i=0; i < num_temperatures; i++)
		gamma_value = cold_gt + (hot_gt - cold_gt)/num_temperatures*i
		leverarm_value = cold_leverarm + (hot_leverarm - cold_leverarm)/num_temperatures*i
				
		global_temps = num2str(e_temps[i]) + base_temps
		

		if (i == 0)
			[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(global_temps, datnums, gamma_over_temp_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, gamma_value=gamma_value, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums, leverarm_value=leverarm_value)
			[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(global_temps, datnums, gamma_over_temp_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums, load_previous_fit=1)
		else
			[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(global_temps, datnums, gamma_over_temp_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums, load_previous_fit=1)
			wave globalfitcoefficients
		endif
		
//		[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(global_temps, datnums, gamma_over_temp_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, gamma_value=gamma_value, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums, leverarm_value=leverarm_value)

		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
		
		cond_chisq_wave[i] = cond_chisq
		occ_chisq_wave[i] = occ_chisq
		dndt_chisq_wave[i] = dndt_chisq
		
		wave globalfitcoefficients
		calc_gt[i] = globalfitcoefficients[0]
		calc_leverarm[i] = globalfitcoefficients[1]
		
		print "Index " + num2str(i) + "/" + num2str(num_temperatures)
	endfor
	
	display
	if (fit_conductance == 1)
		AppendToGraph/L cond_chisq_wave vs e_temps
	endif
	if (fit_entropy == 1)
		AppendToGraph/L dndt_chisq_wave vs e_temps
	endif
	AppendToGraph/R occ_chisq_wave vs e_temps
	
	Label bottom "Electron Temp (mK)"
	if (fit_conductance == 1)
		Label left "Chi Squared Conductance"
	endif
	if (fit_entropy == 1)
		Label left "Chi Squared Entropy"
	endif
	Label right "Chi Squared Occupation"
	ModifyGraph axRGB(left)=(65535,0,0),tlblRGB(left)=(65535,0,0),alblRGB(left)=(65535,0,0)
	
	ModifyGraph rgb(occ_chisq_wave)=(0,0,0), gFont="Calibri", gfSize=14
	
	
	display
	AppendToGraph/L calc_gt vs e_temps
	AppendToGraph/R calc_leverarm vs e_temps
	
	Label bottom "Electron Temp (mK)"
	Label left "ln(G/T)"
	Label right "Leverarm"
	ModifyGraph axRGB(left)=(65535,0,0),tlblRGB(left)=(65535,0,0),alblRGB(left)=(65535,0,0)
	
	ModifyGraph rgb(calc_leverarm)=(0,0,0), gFont="Calibri", gfSize=14
end



//function run_global_fit_wrapper(variable baset, string datnums, string gamma_over_temp_type, [variable global_fit_conductance])
//	variable cond_chisq, occ_chisq, dndt_chisq
//	
//	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data
////	run_clean_average_procedure(datnums=datnums)
////	closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
//	[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(baset, datnums, gamma_over_temp_type, global_fit_conductance = global_fit_conductance)
//	
//	print "Conduction chisq = " + num2str(cond_chisq)
//	print "Occupation chisq = " + num2str(occ_chisq)
//end




function figure_2_entropy()

	string gamma_type
	
	///// SPRING CONDUCTANCE AND TRANSITION DATA ///// 
//	string e_temps = "30;100;300;500"
////	string global_datnums = "6079;6088;6085;6082";  gamma_type = "high"// high gamma
////	string global_datnums = "6080;6089;6086;6083";  gamma_type = "mid" // mid gamma
////	string global_datnums = "6081;6090;6087;6084";  gamma_type = "low" // low gamma
//
//	string entropy_datnums = "6388"; string global_datnums = "6079;6088;6085;6082"; gamma_type = "high"; info_mask_waves("6388", base_wave_name="_cs_cleaned_avg")
////	string entropy_datnums = "6385"; string global_datnums = "6079;6088;6085;6082"; gamma_type = "high"; info_mask_waves("6385", base_wave_name="_cs_cleaned_avg")
//	
//	string global_datnums = "6100;6097;6094;6091"; string gamma_type = "high" // high gamma :: high field
//	string global_datnums = "6225;6234;6231;6228"; string gamma_type = "high" // high gamma :: 2-3 transition
//	string datnums = "6226;6235;6232;6229"; string gamma_type = "high" // high gamma :: 2-3 transition
	
//	///// AUTUMN EXPERIMENT /////
	string e_temps = "90;90;275;400"
//	string entropy_datnums = "1281"; string global_datnums = "1285;1297;1293;1289"; gamma_type = "low"; info_mask_waves("1281", base_wave_name="_cs_cleaned_avg")
//	string entropy_datnums = "1282"; string global_datnums = "1286;1298;1294;1290"; gamma_type = "low"; info_mask_waves("1282", base_wave_name="_cs_cleaned_avg")
//	string entropy_datnums = "1283"; string global_datnums = "1287;1299;1295;1291"; gamma_type = "high"; info_mask_waves("1283", base_wave_name="_cs_cleaned_avg")
	string entropy_datnums = "1284"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1284", base_wave_name="_cs_cleaned_avg") // 100uV bias

//	string entropy_datnums = "1372"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1372", base_wave_name="_cs_cleaned_avg") // 50uV bias
//	string entropy_datnums = "1373"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1373", base_wave_name="_cs_cleaned_avg") // 250uV bias
//	string entropy_datnums = "1374"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1374", base_wave_name="_cs_cleaned_avg") // 500uV bias
//	string entropy_datnums = "1439"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1439", base_wave_name="_cs_cleaned_avg") // 1000uV bias
	
//	string entropy_datnums = "1473"; string global_datnums = "1288;1300;1296;1292"; gamma_type = "high"; info_mask_waves("1473", base_wave_name="_cs_cleaned_avg") // 50uV bias :: symmetric

	
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
	variable cond_chisq, occ_chisq, dndt_chisq
	[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(e_temps, global_datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_conductance=fit_conductance, fit_entropy=fit_entropy, fit_entropy_dats=entropy_datnums)	
	
	Display; KillWindow /Z figure_2a; DoWindow/C/O figure_2a
	Display; KillWindow /Z figure_2b; DoWindow/C/O figure_2b
	Display; KillWindow /Z figure_2c; DoWindow/C/O figure_2c
	
	string cond_avg, cond_avg_fit
	string trans_avg, trans_avg_fit
	string occ_avg, occ_avg_fit
	string dndt_avg, dndt_avg_fit, dndt_coef
	string dndt_nrg_avg_fit, dndt_nrg_coef
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
		
		dndt_coef = "coef_" + dndt_avg
		dndt_nrg_coef = "coef_nrg_" + dndt_avg
		
		// setting dndt occupation names
		dndt_occ_avg = "dat" + num2str(entropy_datnum) + "_cs_cleaned_avg_occ"
		dndt_occ_avg_coef = "coef_dat" + num2str(entropy_datnum) + "_cs_cleaned_avg"
		
		dndt_occ_avg_fit = "fit_" + dndt_occ_avg
		
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
//			dndt_avg_wav -= dndt_offset
//			dndt_avg_fit_wav -= dndt_offset
//			dndt_nrg_avg_fit_wav -= dndt_offset
			
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
			
			wave occ_coef = $dndt_coef
			
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
			variable minx, maxx
			[minx, maxx] = find_overlap_mask($(trans_avg+"_mask"), $(trans_avg+"_mask"))
			
			// interpolating occupation to have higher density of points
			string dndt_vs_occ_data_wave_name_x = dndt_occ_avg + "_interp"
			
			duplicate /o $dndt_occ_avg $dndt_vs_occ_data_wave_name_x
//			interpolate_wave(dndt_vs_occ_data_wave_name_x, $dndt_occ_avg, numpts_to_interp=10000)
			
			// interpolating conduction to have data at same x points as occuptaion data
			string dndt_vs_occ_data_wave_name_y = dndt_avg + "_interp"
			interpolate_wave(dndt_vs_occ_data_wave_name_y, $dndt_avg, xwave_to_duplicate=$dndt_vs_occ_data_wave_name_x)
			
			// deleting points outside of mask
			delete_points_from_x($dndt_vs_occ_data_wave_name_x, minx, maxx)
			delete_points_from_x($dndt_vs_occ_data_wave_name_y, minx, maxx)
			
			
			///////////////////////////////////
			///// interpolating fit waves /////
			///////////////////////////////////
//			///// version 1
//			string dndt_vs_occ_fit_wave_name_x = dndt_occ_avg_fit + "_interp"
//			
//			duplicate /o $dndt_occ_avg_fit $dndt_vs_occ_fit_wave_name_x
////			interpolate_wave(dndt_vs_occ_fit_wave_name_x, $dndt_occ_avg_fit, numpts_to_interp=10000)
//			
//			string dndt_vs_occ_fit_wave_name_y = dndt_avg_fit + "_interp"
//			interpolate_wave(dndt_vs_occ_fit_wave_name_y, $dndt_avg_fit, xwave_to_duplicate=$dndt_vs_occ_fit_wave_name_x)
//	
//				///// interpolating nrg fit wave /////
////			string dndt_nrg_vs_occ_fit_wave_name_x = dndt_nrg_avg_fit + "_interp"
////			interpolate_wave(dndt_vs_occ_fit_wave_name_x, $dndt_nrg_avg_fit, numpts_to_interp=10000)
////			
//			string dndt_nrg_vs_occ_fit_wave_name_y = dndt_nrg_avg_fit + "_interp"
//			interpolate_wave(dndt_nrg_vs_occ_fit_wave_name_y, $dndt_nrg_avg_fit, xwave_to_duplicate=$dndt_vs_occ_fit_wave_name_x)
//			

			///// version 2
	//		///// re-finding fits from NRG /////
			string dndt_vs_occ_fit_wave_name_x = dndt_occ_avg_fit + "_interp"
			string dndt_vs_occ_fit_wave_name_y = dndt_avg_fit + "_interp"
			string dndt_nrg_vs_occ_fit_wave_name_y = dndt_nrg_avg_fit + "_interp"
			
			// pulling x-wave from NRG
			wave dndt_nrg
			create_x_wave(dndt_nrg)
			wave x_wave
			
			// pulling NRG occ
			duplicate /o x_wave $dndt_vs_occ_fit_wave_name_x
			fitfunc_rawnrgocc($dndt_occ_avg_coef, $dndt_vs_occ_fit_wave_name_x)
			
			// pulling NRG dndt
			duplicate /o x_wave $dndt_vs_occ_fit_wave_name_y
			fitfunc_rawnrgdndt($dndt_coef, $dndt_vs_occ_fit_wave_name_y)
			
			// pulling NRG dndt
			duplicate /o x_wave $dndt_nrg_vs_occ_fit_wave_name_y
			fitfunc_rawnrgdndt($dndt_nrg_coef, $dndt_nrg_vs_occ_fit_wave_name_y)
	

	
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
	
//	beautify_figure("figure_2a")
//	beautify_figure("figure_2b")
//	beautify_figure("figure_2c")
	
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
	variable cond_chisq, occ_chisq, dndt_chisq
	[cond_chisq, occ_chisq, dndt_chisq] = run_global_fit(global_temps, global_datnums, gamma_type, global_fit_conductance=global_fit_conductance, fit_entropy=0, fit_entropy_dats=entropy_datnums)
	
	
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


macro compare_cold_entropy_vs_global()

// 1281, 1285 low G/T
// 1282, 1286
// 1283, 1287
// 1284, 1288 high G/T


// cold entropy data :: dat1281_cs_cleaned_avg
// cold entropy coef :: coef_dat1281_cs_cleaned_avg

// cold transition data :: dat1285_cs_cleaned_avg
// cold transition data :: coef_dat1285_cs_cleaned_avg


	// modify entropy data
	duplicate /o dat1284_cs_cleaned_avg dat1284_cs_cleaned_avg_scale
	
	create_x_wave(dat1284_cs_cleaned_avg_scale)
	dat1284_cs_cleaned_avg_scale -= (coef_dat1284_cs_cleaned_avg[4] + coef_dat1284_cs_cleaned_avg[5]*x_wave[p] + coef_dat1284_cs_cleaned_avg[6]*x_wave[p]^2)
	dat1284_cs_cleaned_avg_scale /= coef_dat1284_cs_cleaned_avg[7]
	setscale /I x x_wave[0]-coef_dat1284_cs_cleaned_avg[2], x_wave[inf]-coef_dat1284_cs_cleaned_avg[2], dat1284_cs_cleaned_avg_scale

	// modify global data
	duplicate /o dat1288_cs_cleaned_avg dat1288_cs_cleaned_avg_scale
	
	create_x_wave(dat1288_cs_cleaned_avg_scale)
	dat1288_cs_cleaned_avg_scale -= (coef_dat1288_cs_cleaned_avg[4] + coef_dat1288_cs_cleaned_avg[5]*x_wave[p] + coef_dat1288_cs_cleaned_avg[6]*x_wave[p]^2)
	dat1288_cs_cleaned_avg_scale /= coef_dat1288_cs_cleaned_avg[7]
	setscale /I x x_wave[0]-coef_dat1288_cs_cleaned_avg[2], x_wave[inf]-coef_dat1288_cs_cleaned_avg[2], dat1288_cs_cleaned_avg_scale
	
	display dat1284_cs_cleaned_avg_scale, dat1288_cs_cleaned_avg_scale
	makecolorful()
	legend
	
endmacro

macro save_waves()
	///// SUMMER /////
	// conductance :: CT
	Save/C/O/P=processed_data  dat6079_cs_cleaned_avg as "dat6079_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  dat6088_cs_cleaned_avg as "dat6088_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  dat6085_cs_cleaned_avg as "dat6085_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  dat6082_cs_cleaned_avg as "dat6082_cs_cleaned_avg.ibw"
	
	Save/C/O/P=processed_data  fit_dat6079_cs_cleaned_avg as "fit_dat6079_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  fit_dat6088_cs_cleaned_avg as "fit_dat6088_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  fit_dat6085_cs_cleaned_avg as "fit_dat6085_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  fit_dat6082_cs_cleaned_avg as "fit_dat6082_cs_cleaned_avg.ibw"
	
	Save/C/O/P=processed_data  coef_dat6079_cs_cleaned_avg as "coef_dat6079_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  coef_dat6088_cs_cleaned_avg as "coef_dat6088_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  coef_dat6085_cs_cleaned_avg as "coef_dat6085_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  coef_dat6082_cs_cleaned_avg as "coef_dat6082_cs_cleaned_avg.ibw"
	
	// conductance :: DOT
	Save/C/O/P=processed_data  dat6079_dot_cleaned_avg_interp as "dat6079_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat6080_dot_cleaned_avg_interp as "dat6080_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat6081_dot_cleaned_avg_interp as "dat6081_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat6088_dot_cleaned_avg_interp as "dat6088_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat6085_dot_cleaned_avg_interp as "dat6085_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat6082_dot_cleaned_avg_interp as "dat6082_dot_cleaned_avg_interp.ibw"
	
	Save/C/O/P=processed_data  gfit_dat6079_dot_cleaned_avg_interp as "gfit_dat6079_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat6080_dot_cleaned_avg_interp as "gfit_dat6080_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat6081_dot_cleaned_avg_interp as "gfit_dat6081_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat6088_dot_cleaned_avg_interp as "gfit_dat6088_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat6085_dot_cleaned_avg_interp as "gfit_dat6085_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat6082_dot_cleaned_avg_interp as "gfit_dat6082_dot_cleaned_avg_interp.ibw"
	
	// conductance :: OCC
	Save/C/O/P=processed_data  dat6079_cs_cleaned_avg_occ_interp as "dat6079_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat6080_cs_cleaned_avg_occ_interp as "dat6080_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat6081_cs_cleaned_avg_occ_interp as "dat6081_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat6088_cs_cleaned_avg_occ_interp as "dat6088_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat6085_cs_cleaned_avg_occ_interp as "dat6085_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat6082_cs_cleaned_avg_occ_interp as "dat6082_cs_cleaned_avg_occ_interp.ibw"
	
	Save/C/O/P=processed_data  fit_dat6079_cs_cleaned_avg_occ_interp as "fit_dat6079_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat6080_cs_cleaned_avg_occ_interp as "fit_dat6080_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat6081_cs_cleaned_avg_occ_interp as "fit_dat6081_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat6088_cs_cleaned_avg_occ_interp as "fit_dat6088_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat6085_cs_cleaned_avg_occ_interp as "fit_dat6085_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat6082_cs_cleaned_avg_occ_interp as "fit_dat6082_cs_cleaned_avg_occ_interp.ibw"


	// entropy
	Save/C/O/P=github_processed_data  dat6385_numerical_entropy_avg_interp as "dat6385_numerical_entropy_avg_interp.ibw"
	Save/C/O/P=github_processed_data  dat6388_numerical_entropy_avg_interp as "dat6388_numerical_entropy_avg_interp.ibw"
	
	Save/C/O/P=github_processed_data  fit_dat6385_numerical_entropy_avg_interp as "fit_dat6385_numerical_entropy_avg_interp.ibw"
	Save/C/O/P=github_processed_data  fit_dat6388_numerical_entropy_avg_interp as "fit_dat6388_numerical_entropy_avg_interp.ibw"
	
	// entropy cold
	Save/C/O/P=github_processed_data  dat6385_cs_cleaned_avg_occ_interp as "dat6385_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=github_processed_data  dat6388_cs_cleaned_avg_occ_interp as "dat6388_cs_cleaned_avg_occ_interp.ibw"
	
	Save/C/O/P=github_processed_data  fit_dat6385_cs_cleaned_avg_occ_interp as "fit_dat6385_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=github_processed_data  fit_dat6388_cs_cleaned_avg_occ_interp as "fit_dat6388_cs_cleaned_avg_occ_interp.ibw"

	
	
	
	
	////// AUTUMN //////
	
	// conductance :: CT
	Save/C/O/P=processed_data  dat699_cs_cleaned_avg as "dat699_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  dat695_cs_cleaned_avg as "dat695_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  dat691_cs_cleaned_avg as "dat691_cs_cleaned_avg.ibw"
	
	Save/C/O/P=processed_data  fit_dat699_cs_cleaned_avg as "fit_dat699_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  fit_dat695_cs_cleaned_avg as "fit_dat695_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  fit_dat691_cs_cleaned_avg as "fit_dat691_cs_cleaned_avg.ibw"
	
	Save/C/O/P=processed_data  coef_dat699_cs_cleaned_avg as "coef_dat699_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  coef_dat695_cs_cleaned_avg as "coef_dat695_cs_cleaned_avg.ibw"
	Save/C/O/P=processed_data  coef_dat691_cs_cleaned_avg as "coef_dat691_cs_cleaned_avg.ibw"
	
	// conductance :: DOT
	Save/C/O/P=processed_data  dat696_dot_cleaned_avg_interp as "dat696_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat697_dot_cleaned_avg_interp as "dat697_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat698_dot_cleaned_avg_interp as "dat698_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat699_dot_cleaned_avg_interp as "dat699_dot_cleaned_avg_interp.ibw"
	
	Save/C/O/P=processed_data  dat695_dot_cleaned_avg_interp as "dat695_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  dat691_dot_cleaned_avg_interp as "dat691_dot_cleaned_avg_interp.ibw"
	
	Save/C/O/P=processed_data  gfit_dat696_dot_cleaned_avg_interp as "gfit_dat696_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat697_dot_cleaned_avg_interp as "gfit_dat697_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat698_dot_cleaned_avg_interp as "gfit_dat698_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat699_dot_cleaned_avg_interp as "gfit_dat699_dot_cleaned_avg_interp.ibw"

	Save/C/O/P=processed_data  gfit_dat695_dot_cleaned_avg_interp as "gfit_dat695_dot_cleaned_avg_interp.ibw"
	Save/C/O/P=processed_data  gfit_dat691_dot_cleaned_avg_interp as "gfit_dat691_dot_cleaned_avg_interp.ibw"
	
	// conductance :: OCC
	Save/C/O/P=processed_data  dat696_cs_cleaned_avg_occ_interp as "dat696_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat697_cs_cleaned_avg_occ_interp as "dat697_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat698_cs_cleaned_avg_occ_interp as "dat698_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat699_cs_cleaned_avg_occ_interp as "dat699_cs_cleaned_avg_occ_interp.ibw"

	Save/C/O/P=processed_data  dat695_cs_cleaned_avg_occ_interp as "dat695_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  dat691_cs_cleaned_avg_occ_interp as "dat691_cs_cleaned_avg_occ_interp.ibw"
	
	Save/C/O/P=processed_data  fit_dat696_cs_cleaned_avg_occ_interp as "fit_dat696_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat697_cs_cleaned_avg_occ_interp as "fit_dat697_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat698_cs_cleaned_avg_occ_interp as "fit_dat698_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat699_cs_cleaned_avg_occ_interp as "fit_dat699_cs_cleaned_avg_occ_interp.ibw"

	Save/C/O/P=processed_data  fit_dat695_cs_cleaned_avg_occ_interp as "fit_dat695_cs_cleaned_avg_occ_interp.ibw"
	Save/C/O/P=processed_data  fit_dat691_cs_cleaned_avg_occ_interp as "fit_dat691_cs_cleaned_avg_occ_interp.ibw"
	
	
	// entropy
//	Save/C/O/P=github_processed_data  dat1281_numerical_entropy_avg_interp as "dat1281_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1282_numerical_entropy_avg_interp as "dat1282_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1283_numerical_entropy_avg_interp as "dat1283_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1284_numerical_entropy_avg_interp as "dat1284_numerical_entropy_avg_interp.ibw"
//	
//	Save/C/O/P=github_processed_data  fit_dat1281_numerical_entropy_avg_interp as "fit_dat1281_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1282_numerical_entropy_avg_interp as "fit_dat1282_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1283_numerical_entropy_avg_interp as "fit_dat1283_numerical_entropy_avg_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1284_numerical_entropy_avg_interp as "fit_dat1284_numerical_entropy_avg_interp.ibw"
//	
//	// entropy cold
//	Save/C/O/P=github_processed_data  dat1281_cs_cleaned_avg_occ_interp as "dat1281_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1282_cs_cleaned_avg_occ_interp as "dat1282_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1283_cs_cleaned_avg_occ_interp as "dat1283_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  dat1284_cs_cleaned_avg_occ_interp as "dat1284_cs_cleaned_avg_occ_interp.ibw"
//	
//	Save/C/O/P=github_processed_data  fit_dat1281_cs_cleaned_avg_occ_interp as "fit_dat1281_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1282_cs_cleaned_avg_occ_interp as "fit_dat1282_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1283_cs_cleaned_avg_occ_interp as "fit_dat1283_cs_cleaned_avg_occ_interp.ibw"
//	Save/C/O/P=github_processed_data  fit_dat1284_cs_cleaned_avg_occ_interp as "fit_dat1284_cs_cleaned_avg_occ_interp.ibw"
endmacro







Function dot_fit_function(w,ys,xs) : FitFunc
	Wave w, xs, ys
	// f(x) = Amp*tanh((x - Mid)/(2*theta)) + Linear*x + Const+Quad*x^2
	// w[0] = Amp
	// w[1] = Const
	// w[2] = Theta
	// w[3] = Mid
	// w[4] = Linear
	// w[5] = Quad

	ys= w[0] + (w[1])/((xs - w[2])^2 + w[3])
End