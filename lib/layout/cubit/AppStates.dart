abstract class AppStates {}

class AppInitialState extends AppStates {}

class IndexChangeState extends AppStates {}

class SetDataSuccessful extends AppStates {}

class SetDataError extends AppStates {}

class GetDataSuccessful extends AppStates {}

class GetDataError extends AppStates {}

class NoDataFound extends AppStates {}
