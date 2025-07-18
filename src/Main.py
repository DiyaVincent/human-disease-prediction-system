# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "home"
__date__ = "$26 Apr, 2021 6:30:58 PM$"

from flask import Flask
from flask import flash
from flask import render_template
from flask import request
from flask import session
from flask import url_for
from flask import redirect
import os
import pymysql
from werkzeug.utils import secure_filename
from tkinter import *
import tkinter as tk
import cv2
from tkinter import filedialog
from glob import glob
import numpy as np
import keras    
from keras.utils import np_utils
import imutils
from tensorflow.keras.preprocessing import image                  
from tqdm import tqdm

clas1 = [item[27:-1] for item in sorted(glob("./multiple disease/dataset/*/"))]
print(clas1)
def path_to_tensor(img_path, width=224, height=224):
    print(img_path)
    img = image.load_img(img_path, target_size=(width, height))
    x = image.img_to_array(img)
    return np.expand_dims(x, axis=0)
def paths_to_tensor(img_paths, width=224, height=224):
    list_of_tensors = [path_to_tensor(img_paths, width, height)]
    return np.vstack(list_of_tensors)

from tensorflow.keras.models import load_model
model = load_model('trained_model_CNN.h5')
UPLOAD_FOLDER = "C:/uploads"
ALLOWED_EXTENSIONS = set(["jpg", "jpeg", "tif", "tiff", "png","jfif"])

app = Flask(__name__)
app.secret_key = "1234"
app.password = ""
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024


class Database:
    def __init__(self):
        host = "localhost"
        user = "root"
        password = ""
        db = "diseasedetection"
        self.con = pymysql.connect(
                                   host=host,
                                   user=user,
                                   password=password,
                                   db=db,
                                   cursorclass=pymysql.cursors.DictCursor,
                                   )
        self.cur = self.con.cursor()

    def getuserprofiledetails(self, username):
        strQuery = (
                    "SELECT PersonId,Firstname,Lastname,Phoneno,Address,Recorded_Date FROM personaldetails WHERE Username = '"
                    + username
                    + "' LIMIT 1"
                    )
        self.cur.execute(strQuery)
        result = self.cur.fetchall()
        print(result)
        return result

    def insertpersonaldetails(
                              self, firstname, lastname, phone, email, address, usertype, username, password
                              ):
        print("insertpersonaldetails::" + username)
        strQuery = "INSERT INTO personaldetails(Firstname, Lastname, Phoneno, Emailid, Address, UserType, Username, Password, Recorded_Date) values(%s, %s, %s, %s, %s, %s, %s, %s, now())"
        strQueryVal = (
                       firstname,
                       lastname,
                       phone,
                       email,
                       address,
                       usertype,
                       username,
                       password,
                       )
        self.cur.execute(strQuery, strQueryVal)
        self.con.commit()
        return ""

    def getpersonaldetails(self, username, password, usertype):
        strQuery = (
                    "SELECT COUNT(*) AS c, PersonId FROM personaldetails WHERE Username = '"
                    + username
                    + "' AND Password = '"
                    + password
                    + "' AND UserType = '"
                    + usertype
                    + "' "
                    )
        self.cur.execute(strQuery)
        result = self.cur.fetchall()
        return result

    def getuploaddetails(self):
        strQuery = "SELECT u.UploadId, d.DiseaseName, u.Firstname, u.Lastname, u.Phoneno, u.Emailid, g.GenderName, u.Age, u.ImagePath, u.Results, u.Recorded_Date "
        strQuery += "FROM uploaddetails AS u "
        strQuery += "LEFT JOIN diseasedetails AS d ON d.DiseaseId = u.DiseaseId "
        strQuery += "LEFT JOIN genderdetails AS g ON g.GenderId= u.GenderId "
        strQuery += "ORDER BY u.UploadId DESC "
        strQuery += "LIMIT 1"
        self.cur.execute(strQuery)
        result = self.cur.fetchall()
        print(result)
        return result

    def insertuploaddetails(self, PersonId, DiseaseId, Firstname, Lastname, Phoneno, Emailid, GenderId, Age, ImagePath, Results):
        strQuery = "INSERT INTO uploaddetails(PersonId, DiseaseId, Firstname, Lastname, Phoneno, Emailid, GenderId, Age, ImagePath, Results,  Recorded_Date) values(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, now())"
        strQueryVal = (str(PersonId), str(DiseaseId), str(Firstname), str(Lastname), str(Phoneno), str(Emailid), str(GenderId), str(Age), str(ImagePath), str(Results))
        self.cur.execute(strQuery, strQueryVal)
        self.con.commit()
        return ""

    def getuserpersonaldetails(self, name):
        strQuery = (
                    "SELECT PersonId, Firstname, Lastname, Phoneno, Address, Recorded_Date FROM personaldetails WHERE Username = '"
                    + name
                    + "' "
                    )
        self.cur.execute(strQuery)
        result = self.cur.fetchall()
        print(result)
        return result

    def getimagedetails(self, imgId):
        strQuery = "SELECT i.ImagePath "
        strQuery += "FROM uploaddetails AS i "
        strQuery += "WHERE i.UploadId = (%s) "
        strQueryVal = str(imgId)
        self.cur.execute(strQuery, strQueryVal)
        result = self.cur.fetchall()
        print(result)
        return result

    def getgenderdetails(self):
        strQuery = "SELECT * FROM genderdetails"
        self.cur.execute(strQuery)
        result = self.cur.fetchall()
        return result

    def getdiseasedetails(self, diseaseId):
        strQuery = "SELECT * FROM diseasedetails WHERE DiseaseId = (%s)"
        strQueryVal = str(diseaseId)
        self.cur.execute(strQuery, strQueryVal)
        result = self.cur.fetchall()
        return result


@app.route("/", methods=["GET"])
def loadindexpage():
    return render_template("index.html")

@app.route("/index", methods=["GET"])
def index():
    return render_template("index.html")

@app.route("/uploaddata/<int:diseaseId>", methods=["GET"])
def uploaddata(diseaseId):
    
    def db_query():
        db = Database()
        emps = db.getgenderdetails()
        return emps

    gender_res = db_query()

    def db_query():
        db = Database()
        emps = db.getdiseasedetails(diseaseId)
        return emps

    disease_res = db_query()

    return render_template(
                           "uploaddata_"+str(diseaseId)+".html",
                           genderresult=gender_res,
                           diseaseresult=disease_res,
                           diseaseId=str(diseaseId),
                           content_type="application/json",
                           )


@app.route("/codeuploaddata/<int:diseaseId>", methods=["POST"])
def codeuploaddata(diseaseId):

    def db_query():
        db = Database()
        emps = db.getgenderdetails()
        return emps

    gender_res = db_query()

    def db_query():
        db = Database()
        emps = db.getdiseasedetails(diseaseId)
        return emps

    disease_res = db_query()
    
    disease = request.form["disease"]
    firstname = request.form["firstname"]
    lastname = request.form["lastname"]
    phone = request.form["phone"]
    email = request.form["email"]
    gender = request.form["gender"]
    age = request.form["age"]
    file = request.files["filepath"]
	
    print("disease:", disease)
    print("firstname:", firstname)
    print("lastname:", lastname)
    print("phone:", phone)
    print("email:", email)
    print("gender:", gender)
    print("age:", age)
    print("filename:" + file.filename)
	
    if "filepath" not in request.files:

        flash("Please fill all mandatory fields.")
        return render_template("uploaddata_"+str(diseaseId)+".html", genderresult=gender_res, diseaseresult=disease_res, content_type="application/json")

    else:
    
        if file.filename != "" and disease is not "-Select-"  and firstname is not ""  and lastname is not ""  and phone is not "" and email is not "" and gender is not "-Select-" and age is not "":

            if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))

                filepath = UPLOAD_FOLDER + "/" + file.filename
                print(filepath)
                print("filepath:" + filepath)
                main_img = cv2.imread(filepath)
                test_tensors = paths_to_tensor(filepath)/255
                pred=model.predict(test_tensors)
                pred=np.argmax(pred);
                print('given image disease is  = '+clas1[pred])
               
                db = Database()
                db.insertuploaddetails(str("13"), disease, firstname, lastname, phone, email, gender, age, file.filename, clas1[pred])

                flash("File successfully uploaded, Kindly view the analyzed result's!")
                return redirect(url_for("viewuploadeddata"))

            else:
                flash("Allowed file types are .csv")
                return render_template("uploaddata_"+str(diseaseId)+".html", genderresult=gender_res, diseaseresult=disease_res, content_type="application/json")
        else:
            flash("Please fill all mandatory fields.")
            return render_template("uploaddata_"+str(diseaseId)+".html", genderresult=gender_res, diseaseresult=disease_res, content_type="application/json")


@app.route("/viewuploadeddata", methods=["GET"])
def viewuploadeddata():
    def db_query():
        db = Database()
        emps = db.getuploaddetails()
        return emps

    profile_res = db_query()
    return render_template(
                           "viewuploadeddata.html",
                           result=profile_res,
                           content_type="application/json",
                           )


@app.route("/img/<int:imgId>")
def fetchImg(imgId):
    def db_query():
        db = Database()
        emps = db.getimagedetails(imgId)
        return emps

    profile_res = db_query()

    filename = ""

    for row in profile_res:
        filename = row["ImagePath"]
        print(filename)

    from flask import send_from_directory

    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)


def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS
