data=load('/media/lci/storage/PR2017/plot/4scenes_results.txt')

ORB=data(:,1)
SIFT=data(:,2)
MNG=data(:,3)
UBRF=data(:,4)
BRF=data(:,5)
BTBRF=data(:,6)

bar(data)
Labels = {'kitchen1', 'living1', 'bed', 'kitchen2','living2', 'luke', '5a', '5b','gates362', 'gates381', 'lounge', 'manolis'};
set(gca, 'XTick', 1:12, 'XTickLabel', Labels);
AX=legend('ORB','SIFT','MNG','UBRF','BRF','BTBRF');

LEG = findobj(AX,'type','text');

set(LEG,'FontSize',14)
xlabel('Scenes','FontSize',12)
ylabel('Accuracy','FontSize',12)
ax = gca;
ax.XGrid = 'off';
ax.YGrid = 'on';


