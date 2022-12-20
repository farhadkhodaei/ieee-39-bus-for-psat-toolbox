pactiv=[10,6.5,6.32,5.08,6.5,5.6,5.4,8.3,2.5];
pactivmod=pactiv;
pvinx=[8,1,2,3,4,5,6,7,0];

loadnum=[3,4,7,8,12,15,16,18,20,21,23,24,25,26,27,28,29,31,39];
loadsact=[3.22,5,2.338,5.22,0.075,3.2,3.29,1.58,6.28,2.74,2.475,3.086,2.24,1.39,2.81,2.06,2.835,0.092,11.04];
loadsreact=[0.024,1.84,0.84,1.76,0.88,1.53,0.323,0.3,1.03,1.15,0.846,-0.92,0.472,0.17,0.755,0.276,0.269,0.046,2.5];

sampind=1;


%load current path
cd(Path.data);
%set name of simulunk model file
open_system('d_039');

for lli=1:19
    if (lli==1)
       set_param('d_039/PQ','p4_5q',['[',num2str(loadsact(lli)),'  ',num2str(loadsreact(lli)),']']);
    else
       set_param(['d_039/PQ',num2str(lli-1)],'p4_5q',['[',num2str(loadsact(lli)),'  ',num2str(loadsreact(lli)),']']);
    end
end
%load current path
cd(Path.data);
%set name of simulunk model file
open_system('d_039');
for pindx=1:9
    if (pindx == 9)
        set_param('d_039/PV','p4q',num2str(pactivmod(pindx)));
    else
        set_param(['d_039/PV',num2str(pvinx(pindx))],'p4q',num2str(pactivmod(pindx)));
    end
end
%do power flow and small signal stability analysis
%initialization
Settings.init=0;
Settings.pq2z=1;
clpsat.init=1;
clpsat.pq2z=1;
%analysis
fm_eigen('runsssa');
