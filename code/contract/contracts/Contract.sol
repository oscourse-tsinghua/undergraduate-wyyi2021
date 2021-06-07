pragma solidity ^0.5.16;

contract Contract {
    uint total;
    
    // Time damping
    int delta_rev = 5;
    // Validation
    int theta_s = 2;
    int theta_f = -3;
    // Message
    //mapping(int => int) e_pow = [];
    //int gamma = 0.2;
    int c0 = 5;
    int alpha = 2;
    int beta = -3;
    
    struct user{
        string uuid;
        int num;
        //bool isUsed;
        uint status;
        mapping(int => int) time;
        int quality;
        // Validation
        int validNum;
        // rate*100
        int successValid;
        int failValid;
        // Message
        int interval;
        int dquality;
    }
    
    user tempuser;
    
    mapping(string => user) users;
    
    function initUser(string memory uuid, int lastTime) public {
    	//if(users[uuid].status == 0) {
    		users[uuid].num = 0;
           	users[uuid].status = 1;
           	users[uuid].quality = 40;
           	users[uuid].validNum = 0;
           	users[uuid].successValid = 0;
           	users[uuid].failValid = 0;
           	users[uuid].time[0] = lastTime;
    	//}
    }
    
    function divide(int dividee, int divider) public pure returns(int) {
    	int round = divider / 2;
    	int remain = dividee % divider;
    	if(remain >= round) {
    		return dividee / divider + 1;
    	}
    	else {
    		return dividee / divider;
    	}
    }
    
    function revalueByValidation(string memory uuid, int time, bool result, bool isTest) public{  	
    	int quality = users[uuid].quality;
		int dquality = 0;
		
    	int num = users[uuid].num + 1;
       	users[uuid].num = num;
		
		// time
		users[uuid].time[num] = time;
		int lastTime = users[uuid].time[num-1];
		int interval;
		if(isTest == true) {
			interval = time - lastTime;
		}
		else {
			interval = time - lastTime + 3;
		}
		users[uuid].interval = interval;
		//if(interval < 5) {
			//interval = 5;
		//}
		// result
		int validNum = users[uuid].validNum;
		if(validNum == 0) {
			users[uuid].validNum = 1;
			if(result == true) {
				users[uuid].successValid = 100;
				dquality = theta_s * 200;
			}
			else {
				users[uuid].failValid = 100;
				dquality = theta_f * 200;
			}
		}
		else {
			if(result == true) {
				int successValid = users[uuid].successValid;
				successValid = divide(successValid*validNum + 100, validNum + 1);
				//successValid = (successValid*validNum + 100) / (validNum + 1);
				dquality = theta_s * (successValid + 100) + theta_f * users[uuid].failValid;
				users[uuid].successValid = successValid;
			}
			else {
				int failValid = users[uuid].failValid;
				failValid = divide(failValid*validNum + 100, validNum + 1);
				//failValid = (failValid*validNum + 100) / (validNum + 1);
				dquality = theta_s * users[uuid].successValid + theta_f * (failValid + 100);
				users[uuid].failValid = failValid;
			}
			validNum = validNum + 1;
			users[uuid].validNum = validNum;
		}
		dquality = delta_rev * dquality;
		dquality = divide(dquality, 100*interval);
		quality = quality + dquality;
		
		if (quality > 100) {
		    quality = 100;
		}
		if (quality < 0) {
		    quality = 0;
		}
		users[uuid].dquality = dquality;
		users[uuid].quality = quality;
    }
    
    function clearValidation(string memory uuid) public {
    	if(users[uuid].status == 1) {
    		users[uuid].validNum = 0;
    		users[uuid].successValid = 0;
    		users[uuid].failValid = 0;
    	}
    }
    
    function getQuality(string memory uuid) public view returns (int) {
        if (users[uuid].status == 0) {
            return 0;
        }
        return users[uuid].quality;
    }
    
    function getInterval(string memory uuid) public view returns (int, int, int, int, int, int) {
        if (users[uuid].status == 0) {
            return (-1, -1, -1, -1, -1, -1);
        }
        return (users[uuid].interval, users[uuid].validNum, users[uuid].successValid, users[uuid].failValid, users[uuid].dquality, users[uuid].quality);
    }
    
}

