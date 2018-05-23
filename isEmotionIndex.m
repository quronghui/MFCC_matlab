function [index] = isEmotionIndex(str)
switch (str)
    case 'anger'
        index = 0;
    case 'disgust'
        index = 1;
    case 'anxiety'
        index = 2;
    case 'happiness'
        index = 3;
    case 'sadness'
        index = 4;
    case 'boredom'
        index = 5;
    case 'neutral'
        index = 6;
end