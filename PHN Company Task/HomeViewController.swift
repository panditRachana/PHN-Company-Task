//
//  HomeViewController.swift
//  PHN Company Task
//
//  Created by Rachana Pandit on 22/12/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

@IBOutlet weak var lblUserName:UILabel!
@IBOutlet weak var sliderCollectionView:UICollectionView!
@IBOutlet weak var collGrid:UICollectionView!
@IBOutlet weak var collUser:UICollectionView!
@IBOutlet weak var pageView:UIPageControl!
@IBOutlet weak var constraintGridHeight:NSLayoutConstraint!
    
var userNameToFetch = String()

var arrayImgSlider = [Jwellery]()
var arrayUser = [DataUser]()
    
var timer = Timer()
var counter = 0
    
var arrGridImage = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = userNameToFetch
        arrGridImage = ["tv.jpeg","camera.jpeg","camera1.jpeg","monitor.jpeg"]
        fetchSliderImages()
        setUpCollectionView()
        fetchUsers()
    }
  
    @objc func slideImages()
    {
        if counter<arrayImgSlider.count
        {
            sliderCollectionView.scrollToItem(at: IndexPath(item:counter , section: 0), at: .right, animated: true)
            pageView.currentPage = counter
            counter = counter+1
            print(counter)
            print(pageView.currentPage)
        }
        else
        {
          counter = 0
            sliderCollectionView.scrollToItem(at: IndexPath(item:counter , section: 0), at: .right, animated: false)
          pageView.currentPage = counter
        }
    }
    
    func fetchSliderImages()
    {
       let urlString = "https://fakestoreapi.com/products/category/jewelery"
       let url = URL(string: urlString)
       URLSession.shared.dataTask(with: url!) { data, response, error in
              print(data)
            
            let result = try! JSONDecoder().decode([Jwellery].self, from: data!)
            print(result)
            for eachResult in result
            {
                self.arrayImgSlider.append(eachResult)
            }
            print(self.arrayImgSlider.count)
            DispatchQueue.main.async
            {
                self.pageView.numberOfPages = self.arrayImgSlider.count
                self.pageView.currentPage = 0
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.slideImages), userInfo: nil, repeats: true)
                self.sliderCollectionView.reloadData()
          }
    }.resume()
  }
  
    func fetchUsers()
    {
        let urlString = "https://reqres.in/api/users?page=2"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
              print(data)
            
            let result = try! JSONDecoder().decode(Response.self, from: data!)
            print(result)
            for eachUser in result.data
            {
                self.arrayUser.append(eachUser)
            }
            print(self.arrayUser.count)
            DispatchQueue.main.async
            {
                self.collUser.reloadData()
            }
    }
    .resume()
}
    
    func setUpCollectionView()
   {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 2
       collGrid.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: CollectionView Methods
extension HomeViewController:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if(collectionView == collGrid)
        {
            let detailPg = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            navigationController?.pushViewController(detailPg, animated: true)
        }
    }
}

extension HomeViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == sliderCollectionView
        {
            return arrayImgSlider.count
        }
        else if collectionView == collGrid
        {
            return arrGridImage.count
        }
        else
        {
            return arrayUser.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == sliderCollectionView
        {
            let cell =  sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
              
            let imageResize = SDImageResizingTransformer(size: CGSize(width: 360 , height: sliderCollectionView.frame.height), scaleMode:.aspectFit)
            
            print(sliderCollectionView.frame.width)
            print(sliderCollectionView.frame.height)
            
            print(cell.imgSlider.frame.width)
            
            cell.imgSlider.sd_setImage(with: NSURL(string: arrayImgSlider[indexPath.row].image)as URL?,  placeholderImage: nil, context: [.imageTransformer: imageResize])
        
              return cell

        }
        else if collectionView == collGrid
        {
            let cell =  self.collGrid.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.imgGrid.image = UIImage(named: arrGridImage[indexPath.row])
            constraintGridHeight.constant = CGFloat((self.arrGridImage.count/2) * 100)
            return cell
        }
        else
        {
            let cell =  self.collUser.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
            let image = arrayUser[indexPath.row].avatar
            let url = URL(string: image)
            let dataImg = try? Data(contentsOf:url!)
            cell.imgUser.image = UIImage(data: dataImg!)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == collGrid
        {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = self.collGrid.frame.width / 2 - lay.minimumInteritemSpacing
            return CGSize(width: widthPerItem - 8, height: 100)

        }
        else if collectionView == collUser
        {
            return CGSize(width: Int(collUser.frame.width)/arrayUser.count, height: 120)
        }
        else
        {
            return CGSize(width: 360, height: sliderCollectionView.frame.height)
        }
        
    }
}
