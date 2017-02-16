clear all;
close all;

kings_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/Kings_BT/ang_location_error.txt');
kings_bt=kings_error(:,1);
kings_ang_error=kings_error(:,2);
kings_trans_error=kings_error(:,3);

oldHospital_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/OldHospital_BT/OH_ang_location_error.txt');
bt_oldHospital=oldHospital_error(:,1);
ang_error=oldHospital_error(:,2);
trans_error=oldHospital_error(:,3);

SF_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/ShopFacade_BT/ShopFacade_ang_location_error.txt');
SF_bt=SF_error(:,1);
SF_ang_error=SF_error(:,2);
SF_trans_error=SF_error(:,3);

SM_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/StMarysChurch_BT/StMarysChurch_ang_trans.txt');
SM_bt=SM_error(:,1);
SM_ang_error=SM_error(:,2);
SM_trans_error=SM_error(:,3);

%GC_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/GreatCourt_BT/GreatCourt_ang_trans.txt');
%GC_bt=GC_error(:,1);
%GC_ang_error=GC_error(:,2);
%GC_trans_error=GC_error(:,3);

SM_error=load('/Users/jimmy/Desktop/PR2017/data_analysis/StMarysChurch_BT/StMarysChurch_ang_trans.txt')

SM_bt=SM_error(:,1);
SM_ang_error=SM_error(:,2);
SM_trans_error=SM_error(:,3);

figure
plot(kings_bt-1, kings_ang_error,'-+')
hold on;
plot(bt_oldHospital-1, ang_error,'--mo');
hold on;
plot(SF_bt-1, SF_ang_error,'-r^');
hold on;
%plot(SM_bt, SM_ang_error,':bs');
hold on;
plot(SM_bt-1, SM_ang_error,'-s');
hold on;
%title('rotational error')
ylabel('Median rotational error (degrees)','FontSize',24);
xlabel('Number of backtracking leaf nodes','FontSize',24);
legend1=legend('Kings','Old Hospital','Shop Facade', 'St Marys');
set(legend1,'FontSize',14);
xlim([0, 20])
ylim([0 1.8])
set(gca, 'FontSize', 16);
figure 
plot(kings_bt-1, kings_trans_error,'-+');
hold on;
plot(bt_oldHospital-1, trans_error,'--mo')
hold on;
plot(SF_bt-1, SF_trans_error,'-r^')
hold on;
plot(SM_bt-1, SM_trans_error,'-s')

xlim([0, 20])
ylim([0,1.2])
%title('translational error')
ylabel('Median translational error (meters)','FontSize',24);
xlabel('Number of backtracking leaf nodes','FontSize',24);
legend2=legend('Kings','Old Hospital','Shop Facade', 'St Marys','FontSize',24);
set(legend2,'FontSize',16)
set(gca, 'FontSize', 16);
