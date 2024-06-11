void main(){

}

traditionalIfElse(bool isLogin, bool isNormalUser){
  if(isLogin){
    if(isNormalUser){
      return 'Go to User Page';
    }else{
      return 'Go to Admin Page';
    }
  }else{
    return 'Go to Login Page';
  }
}

withGuardClause(bool isLogin, bool isNormalUser){
  if(!isLogin){
    return 'Go to Login Page';
  }
  if(!isNormalUser){
    return 'Go to Admin Page';
  }
  return 'Go to User Page';
}