pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Datatypes {
    uint32 public timestamp;
    uint8 public shortuInt;
    int256 public longInt;
    int public my256Int;

    struct student{
            uint8 age;
            string firstname;
            string lastname;
        }

    uint8[] myArray = [ 1, 1];
    int[] myArray1 = [ int256(2), 1];

    constructor() public {
        int[] myArray2;
        myArray2[0]=77;

       uint16[3] myArray3 = [uint16(1),2,3]; 

       myArray3.length;

       if(myArray2.empty()){
           myArray2.push(55);
       }
       else{
           myArray2.pop();
       }

        byte myOnlyCharByte = "a";
        byte[] bytesArray;
        bytes anotherBytesArray = "fdjgjkdsk";

        anotherBytesArray.length;
        bytes slice = anotherBytesArray[1:3];

        string sampleString = "rtupoeirupiowuprioutipow";
        sampleString.substr(1,5);
        sampleString.append("sdfgasfg");
        sampleString.find(byte('f'));
        sampleString.findLast(byte('f'));
        stoi(sampleString);

        student myStudent = student(21, "Ivan", "Petrov");
        uint8 age = myStudent.age;

        mapping(string => string) assocArray;
        assocArray["passport787645"] = "Ivan Sidodrov";
        mapping(student => uint8) studentMark;
        studentMark[myStudent] = 9;
    
    timestamp = now;
    }


}