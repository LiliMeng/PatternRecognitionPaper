clear all;
close all;

apt1_living=load('/Users/jimmy/Desktop/BT_random_v1/4scenes/apt1/living/apt1_living_BT_results.txt')
apt2_living=load('/Users/jimmy/Desktop/BT_random_v1/4scenes/apt2/living/apt2_living_BT_results.txt')
a = load('/Users/jimmy/Desktop/BT_random_v1/4scenes/office2/5a/5a_BT_results.txt')
gates362=load('/Users/jimmy/Desktop/BT_random_v1/4scenes/office1/gates362/gates362_BT_result.txt')

BT_number=apt1_living(:,1);

percen_apt1_living=apt1_living(:,4)
percen_apt2_living=apt2_living(:,4)
percen_5a=a(:,4)
percen_gates362=gates362(:,4)

percen_mean=(percen_apt1_living+percen_apt2_living+percen_5a+percen_gates362)/4

plot(BT_number-1, percen_apt1_living, '-^')

hold on;
plot(BT_number-1, percen_apt2_living, '-o')
hold on;
plot(BT_number-1, percen_5a, '-x')
hold on;
plot(BT_number-1, percen_gates362, '-v')
hold on;
plot(BT_number-1, percen_mean, '--d')
xlim([0, 31])
h_legend=legend('Apt1/living','Apt2/living', 'Office2/5a', 'Office1/gates362', 'Mean')
set(h_legend,'FontSize',16)
xlabel('Backtracking leaf node numbers','FontSize',24);
ylabel('Correct frames percentage','FontSize',24);
set(gca, 'FontSize', 16);
