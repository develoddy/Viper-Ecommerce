//
//  WebSender.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//
// Realiza las solicitudes POST y maneja la respuesta del servidor.

import UIKit

class WSender: NSObject {
    
   
    // MARK: - CONSUMPTION OF SERVICE WITH COOKIE
     
    // POST
    @discardableResult class func doPOSTCookieToURL(conURL url                  : NSString                              ,
                                                    conPath path                : NSString                              ,
                                                    conParametros parametros    : Any?                                  ,
                                                    conCookie cookie            : NSString                              ,
                                                    conCompletion completion    : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///GET
    @discardableResult class func doGETCookieToURL(conURL url               : NSString                              ,
                                                   conPath path             : NSString                              ,
                                                   conParametros parametros : Any?                                  ,
                                                   conCookie cookie         : NSString                              ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///PUT
    @discardableResult class func doPUTCookieToURL(conURL url               : NSString                          ,
                                                   conPath path             : NSString                          ,
                                                   conParametros parametros : Any?                              ,
                                                   conCookie cookie         : NSString                          ,
                                                   conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithCookie(cookie) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    // MARK: - CONSUMPTION OF SERVICE WITH TOKKEN
    
    // POST
    @discardableResult class func doPOSTTokenToURL(conURL url: NSString,
                                                   conPath path: NSString,
                                                   conParametros parametros: Any?,
                                                   conToken token: String, ///NSString,
                                                   conCompletion completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPost
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///GET
    @discardableResult class func doGETTokenToURL(conURL url                : NSString                              ,
                                                  conPath path              : NSString                              ,
                                                  conParametros parametros  : Any?                                  ,
                                                  conToken token            : String                              ,
                                                  conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        print("Debbug WSSender doGETTokenToURL y obtengo la URL: \(urlServicio)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    ///PUT
    @discardableResult class func doPUTTokenToURL(conURL url                : NSString                              ,
                                                  conPath path              : NSString                              ,
                                                  conParametros parametros  : Any?                                  ,
                                                  conToken token            : String , ///NSString                              ,
                                                  conCompletion completion  : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequestWithToken(token) as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    // MARK: - CONSUMPTION SERVICE SIMPLE

    // Metodo Post
    //@discardableResult
    class func doPOSTToURL(conURL url: NSString, conPath path: NSString, conParametros parametros: [String: Any], conCompletion completion: @escaping (_ objRespuesta: WebResponse) -> Void) -> URLSessionDataTask {
    //class func doPOSTToURL(conURL: String, conPath: NSString, conParametros: [String: Any], completion: @escaping (WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)\(path.hasPrefix("/") ? path as String : "/\(path)")")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parametros, options: [])
        } catch {
            print("Error al serializar JSON: \(error.localizedDescription)")
        }
        
        
        request.httpMethod = Constants.Method.httpPost
        
        // Realizar la solicitud
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                let webResponse = WebResponse()
                webResponse.dataResponse = data
                webResponse.statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                
                if let error = error {
                    webResponse.error = error as NSError
                    completion(webResponse)
                    return
                }
                
                // Aquí deberías verificar y asignar respuestaJSON si es necesario
                do {
                    if let data = data {
                        webResponse.respuestaJSON = try JSONSerialization.jsonObject(with: data, options: [])
                    }
                } catch {
                    print("Error al procesar la respuesta JSON: \(error.localizedDescription)")
                }
                
                completion(webResponse)
            }
        }
        
        task.resume()
        return task
    }
    
    // Metodo GET
    @discardableResult class func doGETToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        
        request.httpMethod = Constants.Method.httpGet
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    // Metodo PUT
    @discardableResult class func doPUTToURL(conURL url                 : NSString                              ,
                                             conPath path               : NSString                              ,
                                             conParametros parametros   : Any?                                  ,
                                             conCompletion completion   : @escaping (_ objRespuesta : WebResponse) -> Void) -> URLSessionDataTask {
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.createHeaderRequest() as? [AnyHashable: Any]
        let sesion = URLSession.init(configuration: configuracionSesion)
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch {}
        }
        request.httpMethod = Constants.Method.httpPut
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let objRespuesta = self.getServiceResponse(paraData: data, conResponse: response, conError: error as NSError?)
                completion(objRespuesta)
            })
        }
        postDataTask.resume()
        return postDataTask
    }
    
    
    // MARK: -           CONFIGURATIONS HEADERS
    class func createHeaderRequest() -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        return diccionarioHeader
    }

    class func createHeaderRequestWithToken(_ aToken : String) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aToken)", forKey: "Authorization" as NSCopying)
        return diccionarioHeader
    }
    
    class func createHeaderRequestWithCookie(_ aCookie : NSString) -> NSDictionary {
        let diccionarioHeader = NSMutableDictionary()
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        return diccionarioHeader
    }
    
    
    // MARK: - TRATADO DE RESPUESTA DEL BACKEND.
    class func detResponseInJSONWithData(_ data : Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        } catch { return nil }
    }
    
    class func getServiceResponse(paraData data: Data?, conResponse response: URLResponse?, conError error: NSError?) -> WebResponse {
            var respuesta: Any? = nil
            if error == nil, let data = data {
                respuesta = self.detResponseInJSONWithData(data)
            }
            
            let urlResponse = response as? HTTPURLResponse
            let headerFields: NSDictionary? = urlResponse?.allHeaderFields as NSDictionary?
            let objResponse = WebResponse()
        
            objResponse.respuestaJSON = respuesta
            objResponse.statusCode = urlResponse?.statusCode
            objResponse.dataResponse = data
            objResponse.error = error
            objResponse.datosCabecera = headerFields
            objResponse.token = headerFields?["_token"] as? NSString
            objResponse.cookie = headerFields?["_token"] as? NSString
            return objResponse
        }
}
