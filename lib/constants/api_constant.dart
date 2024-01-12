abstract class ApiConstant {
  ApiConstant._();

  static const predictAllApi =
      "http://10.0.2.2:8000/predict_all"; // For Emulator
  //static const String predictAllApi = 'http://192.168.1.16:8000/predict_all';
  //static const String predictAllApi = 'http://127.0.0.1:8000/predict_all'; // For Postman

  static const nutritionFactsApi =
      "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query";
  static const nutritionFactsApiKey =
      "ac26b7722bmsh727bee59e0f8b96p1d2d5fjsn48efcb9eec76";
  static const nutritionFactsApiHost =
      "nutrition-by-api-ninjas.p.rapidapi.com";

  static const findWorkoutApi =
      "https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?muscle";
  static const findWorkoutApiKey =
      "ac26b7722bmsh727bee59e0f8b96p1d2d5fjsn48efcb9eec76";
}
