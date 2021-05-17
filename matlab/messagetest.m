gammas = [0.05, 0.2, 0.5];
averecord = zeros(3, 11);
errmax = zeros(3, 11);
errmin = zeros(3, 11);
for gn = 1:3
    gamma = gammas(gn);
    crowdnum = 5:15;
    for cn = 1:11
        center = 20;
        crowd = round(rand(crowdnum(cn), 1) * 10 + center - 5);
        e = exp(1);

        testnum = 10000;
        totalave = 0;
        max = -1;
        min = 20;
        for j = 1:testnum
            sum = 0;
            weight = 0;
            for i = 1:crowdnum(cn)
                distance = abs(crowd(i) - center);
                if distance <= 2
                    rate = round(rand() * 4) + 6;
                else
                    rate = round(rand() * 6);
                end
                %rate = round(rand() * 10);
                sum = sum + e^(gamma*distance) * rate;
                weight = weight + e^(gamma*distance);
            end
            ave = round(sum / weight);
            totalave = totalave + ave;
            if ave > max
                max = ave;
            end
            if ave < min
                min = ave;
            end
        end
        totalave = totalave / testnum;
        averecord(gn, cn) = totalave;
        errmax(gn, cn) = max - totalave;
        errmin(gn, cn) = totalave - min;
    end
end
%plot(crowdnum, averecord(1,:), crowdnum, averecord(2,:), crowdnum, averecord(3,:), crowdnum, averecord(4,:));
errorbar(crowdnum, averecord(1,:), errmin(1,:), errmax(1,:));
hold on;
errorbar(crowdnum, averecord(2,:), errmin(2,:), errmax(2,:));
errorbar(crowdnum, averecord(3,:), errmin(3,:), errmax(3,:));
axis([5 15 0 10]);
xlabel('car number');
ylabel('average rating');
legend('gamma=0.05', 'gamma=0.2', 'gamma=0.5', 'Location', 'SouthEast');